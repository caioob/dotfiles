#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

MONITORS_CONF="$HOME/.config/hypr/monitors.conf"

notify_err() {
  local msg="$1"
  if command -v notify-send >/dev/null 2>&1; then
    notify-send "hypr/monitors.sh" "$msg"
  else
    printf '%s\n' "$msg" >&2
  fi
}

hypr_monitors_json() {
  command -v hyprctl >/dev/null 2>&1 || return 1
  hyprctl monitors -j 2>/dev/null
}

list_outputs() {
  local json
  if json="$(hypr_monitors_json)" && [[ -n "$json" ]]; then
    python3 - <<'PY'
import json,sys
try:
    data=json.load(sys.stdin)
except Exception:
    sys.exit(1)
for m in data:
    name=m.get('name')
    if name:
        print(name)
PY
    return 0
  fi

  command -v wlr-randr >/dev/null 2>&1 || return 1
  wlr-randr 2>/dev/null |
    awk '/^[^[:space:]]/ {name=$1; sub(/:$/, "", name); print name}'
}

list_modes_for_output() {
  local mon="$1"
  local json
  if json="$(hypr_monitors_json)" && [[ -n "$json" ]]; then
    python3 - "$mon" <<'PY'
import json,sys
mon=sys.argv[1]
try:
    data=json.load(sys.stdin)
except Exception:
    sys.exit(1)
for m in data:
    if m.get('name')==mon:
        for mode in (m.get('availableModes') or []):
            print(mode)
        break
PY
    return 0
  fi

  command -v wlr-randr >/dev/null 2>&1 || return 1
  wlr-randr 2>/dev/null |
    awk -v mon="$mon" '
      $1==mon || $1==(mon ":") {in=1; next}
      in && /^[^[:space:]]/ {in=0}
      in && /Hz/ {print}
    '
}

monitor_name="$(
  list_outputs |
    sed '/^$/d' |
    tofi --prompt-text "Escolha o monitor"
)"

if [[ -z "${monitor_name:-}" ]]; then
  exit 1
fi

resolution_selected="$(
  list_modes_for_output "$monitor_name" |
    sed 's/(.*)//g' |
    sed 's/[[:space:]]//g' |
    tofi --prompt-text "Escolha a resolucao para o monitor $monitor_name"
)"

if [[ -z "${resolution_selected:-}" ]]; then
  exit 1
fi

resolution_treated="$(
  printf '%s' "$resolution_selected" |
    sed 's/Hz//g' |
    sed 's/px//g' |
    sed 's/,/@/g' |
    sed -E 's/@([0-9]+)\.0+$/@\1/' |
    sed -E 's/@([0-9]+)\.[0-9]+$/@\1/'
)"

if [[ -z "${resolution_treated:-}" ]]; then
  notify_err "Nenhum modo encontrado para $monitor_name (verifique hyprctl/wlr-randr)"
  exit 1
fi

tmp_conf="$(mktemp "${MONITORS_CONF}.tmp.XXXXXX")"

{
  if [[ -f "$MONITORS_CONF" ]]; then
    awk -v mon="$monitor_name" '
      BEGIN { prefix = "monitor=" mon "," }
      substr($0, 1, length(prefix)) != prefix { print }
    ' "$MONITORS_CONF"
  fi

  printf 'monitor=%s,%s,0x0,1\n' "$monitor_name" "$resolution_treated"
} > "$tmp_conf"

mv "$tmp_conf" "$MONITORS_CONF"
