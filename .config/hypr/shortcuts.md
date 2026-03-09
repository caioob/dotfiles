# Shortcuts
$mainMod is set to SUPER, so I’m listing binds with SUPER expanded.
 - SUPER+SHIFT+I -> exec ~/.config/hypr/gamemode.sh
 - SUPER+K -> layoutmsg move +col
 - SUPER+J -> layoutmsg move -col
 - SUPER+ScrollDown -> layoutmsg move +col
 - SUPER+ScrollUp -> layoutmsg move -col
 - SUPER+Backspace -> exec alacritty -o font.size=12 -e btop
 - SUPER+Z -> pin
 - ALT+SHIFT+S -> global caelestia:screenshotFreezeClip
 - SUPER+F1 -> global caelestia:dashboard
 - SUPER+F2 -> global caelestia:controlCenter
 - SUPER+SHIFT+H -> layoutmsg swapcol r
 - SUPER+SHIFT+L -> layoutmsg swapcol l
Resize submap:
 - SUPER+R -> enter submap Resize
 - (in Resize) L -> resizeactive 10 0 (repeat)
 - (in Resize) H -> resizeactive -10 0 (repeat)
 - (in Resize) K -> resizeactive 0 -10 (repeat)
 - (in Resize) J -> resizeactive 0 10 (repeat)
 - SUPER+R -> submap reset
 - Escape -> submap reset
Workspaces:
 - SUPER+1..9 -> workspace 1..9
 - SUPER+0 -> workspace 10
 - SUPER+SHIFT+1..9 -> movetoworkspace 1..9
 - SUPER+SHIFT+0 -> movetoworkspace 10
 - SUPER+W -> workspace 1 (duplicate of SUPER+1)
 - SUPER+Tab -> workspace previous
 - SUPER+N -> workspace empty
Screenshots:
 - SUPER+Print -> exec hyprshot -m region
 - SUPER+SHIFT+Print -> exec hyprshot -m output
Special workspaces:
 - SUPER+S -> togglespecialworkspace discord
 - SUPER+SHIFT+S -> movetoworkspace special:discord
 - SUPER+G -> togglespecialworkspace steam
 - SUPER+SHIFT+G -> movetoworkspace special:steam
 - SUPER+F9 -> togglespecialworkspace keepass
 - SUPER+SHIFT+F9 -> movetoworkspace special:keepass
 - SUPER+M -> togglespecialworkspace terminal
 - SUPER+SHIFT+M -> movetoworkspace special:terminal
Waybar:
 - SUPER+SHIFT+r -> exec killall waybar && waybar & disown
Mouse:
 - SUPER+mouse:272 -> movewindow
 - SUPER+mouse:273 -> resizewindow
Apps / misc:
 - SUPER+V -> exec cliphist list | tofi | cliphist decode | wl-copy
 - SUPER+Return -> exec alacritty -e tmux
 - SUPER+SHIFT+Return -> exec alacritty -e tmux a
 - SUPER+Q -> killactive
 - SUPER+SHIFT+Q -> global caelestia:session
 - SUPER+E -> exec dolphin
 - SUPER+SHIFT+F -> togglefloating 
 - SUPER+P -> pseudo
 - SUPER+F -> fullscreen
 - SUPER+d -> global caelestia:launcher
 - SUPER+U -> exec $HOME/.config/hypr/mount.sh -u
 - SUPER+SHIFT+U -> exec $HOME/.config/hypr/mount.sh
 - F10 -> pass (only for class:^(soundux)$)
