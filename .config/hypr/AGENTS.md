# Agent Notes (Hyprland Config)

This repository is a Hyprland configuration bundle (Hyprland + Hypr ecosystem configs and a few helper shell scripts). There is no conventional "build" or unit test suite; the main feedback loop is reloading Hyprland and linting shell scripts.

Primary languages/formats:

- Hyprland `.conf` files
- Shell scripts (`sh`/`bash`)

No Cursor rules were found in `.cursor/rules/` or `.cursorrules`.
No Copilot instructions were found in `.github/copilot-instructions.md`.

## Layout

- `hyprland.conf`: main entrypoint; composes config via `source = ...`
- `binds.conf`: keybinds and submaps
- `input*.conf`, `monitors*.conf`, `plugins.conf`: device/layout/plugin settings
- `execs.conf`: startup commands
- `hyprlock.conf`, `hypridle.conf`: lock/idle (idle file currently empty)
- `*.sh`: helper scripts invoked by binds/execs

## Build / Lint / Test Commands

### Reload / Smoke Test (primary "test")

- Reload Hyprland after config edits:
  - `hyprctl reload`
- Verify a setting changed (examples):
  - `hyprctl getoption animations:enabled`
  - `hyprctl getoption general:gaps_out`
- Inspect runtime state:
  - `hyprctl monitors`
  - `hyprctl clients`
  - `hyprctl binds` (useful after changing `binds.conf`)

If reload fails or behavior is odd, check the Hyprland logs for parse errors (varies by setup):

- `journalctl --user -b | rg -i "hypr"` (or `journalctl --user -b | grep -i hypr`)

### Shell Script Linting

- Lint all shell scripts (recommended):
  - `shellcheck -x ./*.sh`

- Syntax-check a single script ("single test"):
  - Bash scripts: `bash -n path/to/script.sh`
  - POSIX sh scripts: `sh -n path/to/script.sh`

- Lint a single script ("single test"):
  - `shellcheck -x path/to/script.sh`

### Formatting

There is no enforced formatter for Hyprland `.conf` files.

For shell scripts, if `shfmt` is installed:

- Format all scripts:
  - `shfmt -w -i 2 -ci ./*.sh`
- Format one script:
  - `shfmt -w -i 2 -ci path/to/script.sh`

## Hyprland Config Conventions

### Composition

- Keep `hyprland.conf` as the composition root and prefer splitting features into dedicated `*.conf` files.
- Think of `source = ...` as the repo's "imports"; keep sources grouped at the top of `hyprland.conf`.
- Prefer `source = $HOME/.config/hypr/<file>` (consistent with existing usage).

### Binds

- Keep `binds.conf` as the single source of truth for binds.
- When adding or changing binds, also update `shortcuts.md` in the same change so the human-readable shortcut list stays in sync.
- Prefer the existing style used in this repo:
  - `bind = $mainMod SHIFT, X, dispatcher, args`
  - Avoid undefined variables like `$mainMod_SHIFT` (use `$mainMod SHIFT` instead).
- When adding submaps:
  - Clearly bracket them with `submap=<Name>` and `submap=reset`.
  - Ensure there is an escape route back to `reset` (e.g. `Escape`).

### Spacing / Formatting

- In blocks (`general {}`, `input {}`), keep `key = value` with one space around `=`.
- For "inline" directives (`monitor=...`, `exec-once=...`), keep the existing style of the file you're editing; do not reformat unrelated lines.
- Keep comments short and actionable; prefer deleting dead config over accumulating many commented variants unless it documents a known workaround.

### External Commands

This config depends on several external tools referenced by binds/startup scripts (non-exhaustive):

- `hyprctl`, `hyprshot`, `wl-paste`, `wl-copy`, `cliphist`, `tofi`
- `swww`, `nm-applet`, `waybar`, `inotifywait`
- `pkexec`, `notify-send`, `lsblk`, `wlr-randr`, `wvkbd-deskintl`
- `caelestia` (used for dashboard/control center/launcher/shell)

When changing a bind/script that calls an external tool, keep failure modes in mind (missing binary, empty selection, permission prompts).

## Shell Script Style Guidelines

### Shell Choice

- Use `#!/usr/bin/env bash` only if you rely on bash features (`[[ ... ]]`, arrays, `set -o pipefail`, etc.).
- Otherwise prefer `#!/bin/sh` for portability.
- Match the existing script's shell unless there's a reason to change.

### Safety / Error Handling

- Quote variables unless you explicitly want word splitting/globbing:
  - Prefer `"$HOME/.config/hypr/..."` over `$HOME/.config/hypr/...`.
- Prefer `[[ ... ]]` in bash scripts and `[ ... ]` in POSIX sh scripts.
- Handle empty/invalid user selections explicitly (e.g. when `tofi` returns nothing).
- For scripts that mutate state (mounting, writing config files), be conservative:
  - Check preconditions and print a clear error (`notify-send` is fine here).
  - Prefer atomic writes when generating `.conf` (write to temp + move) if practical.

Recommended bash defaults for new non-trivial scripts:

```bash
set -euo pipefail
IFS=$'\n\t'
```

Use a `trap` when a script starts long-running background processes that need cleanup.

### Naming

- Variables: `UPPER_SNAKE_CASE` for env-like constants, `lower_snake_case` for locals.
- Functions: `lower_snake_case`.
- Script names: short, descriptive, `lowercase` (current repo uses e.g. `mount.sh`, `gamemode.sh`).

### Command Output Parsing

- Prefer structured outputs when available; avoid brittle `grep | awk | sed` pipelines if a tool offers a machine-readable mode.
- If you must parse text output:
  - Keep pipelines readable (one transformation per stage).
  - Avoid relying on column widths/spaces unless the command guarantees it.

## Making Changes Safely

- Keep edits tightly scoped; do not reformat entire config files for one functional change.
- When changing keybinds, ensure the new binding does not collide with an existing one (check `binds.conf` and `hyprctl binds`).
- After changing startup commands (`execs.conf`, `starthypr.sh`), validate idempotence: repeated runs should not spawn unbounded duplicates unless intended.

## Common Workflows

### Add or Modify a Keybind

1. Edit `binds.conf`.
2. Run `hyprctl reload`.
3. Confirm with `hyprctl binds` and a manual key press.

### Edit a Script Triggered by a Bind

1. Update the script under `./`.
2. Run `shellcheck -x path/to/script.sh`.
3. Run a local "single test":
   - `bash -n path/to/script.sh` (or `sh -n`)
4. Trigger via the keybind (or run the script directly).
