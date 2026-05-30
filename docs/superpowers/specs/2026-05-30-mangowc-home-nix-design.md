# MangoWC home.nix Configuration Design

**Date:** 2026-05-30
**Status:** Approved

## Overview

Migrate the user's NixOS home-manager config from Hyprland to MangoWC (pkgs.mangowc, v0.12.8 — a dwl-based lightweight Wayland compositor). MangoWC is already enabled system-wide in `configuration.nix` (`programs.mangowc.enable = true`) and greetd already launches `mango` by default. The work is entirely in `home.nix`.

## Scope

Three targeted changes to `/home/bugzy/.config/nixos/home.nix`:

1. Add `xdg.configFile."mango/config.conf"` block
2. Update `programs.waybar` workspace module from `hyprland/workspaces` to `ext/workspaces`
3. Disable `wayland.windowManager.hyprland` with `enable = false` (keep the config for easy re-enable)

No changes to `configuration.nix`. No new files beyond the spec and plan.

## MangoWC Config Content

Written to `~/.config/mango/config.conf` via `xdg.configFile`.

### Monitor
```
monitor=,preferred,auto,auto
```

### Autostart
```
exec-once=waybar
exec-once=swaybg -i /home/bugzy/Pictures/wallpapers/nixos.png -m fill
```

### Environment
```
env=XCURSOR_THEME,Bibata-Modern-Classic
env=XCURSOR_SIZE,24
```

### General
```
general {
    gaps_in=5
    gaps_out=20
    border_width=2
    active_border_color=#e8e8e8
    inactive_border_color=#2a2a2a
}
```

### Decoration
Rounding=0 (sharp corners), blur (size 3, 1 pass), shadow (range 4, color #1a1a1a). Matches existing dark monochrome aesthetic.

### Input
US keyboard layout, natural scroll off, sensitivity 0, touchpad natural scroll off.

### Keybindings
Mirror of existing Hyprland binds — no muscle memory changes:

| Bind | Action |
|------|--------|
| SUPER+Q | spawn kitty |
| SUPER+C | killactive |
| SUPER+M | quit |
| SUPER+E | spawn dolphin |
| SUPER+V | togglefloating |
| SUPER+D | spawn rofi -show drun |
| SUPER+F | fullscreen |
| SUPER+Arrows | movefocus |
| SUPER+1–0 | workspace 1–10 |
| SUPER+SHIFT+1–0 | movetoworkspace 1–10 |
| SUPER+S | togglespecialworkspace magic |
| SUPER+SHIFT+S | movetoworkspace special:magic |
| SUPER+scroll | workspace e±1 |
| SUPER+left drag | movewindow |
| SUPER+right drag | resizewindow |

### Layout Switching (new — not in Hyprland config)

| Bind | Layout |
|------|--------|
| SUPER+SHIFT+T | master-stack |
| SUPER+SHIFT+G | grid |
| SUPER+SHIFT+M | monocle |
| SUPER+SHIFT+D | deck |

### Media / Brightness / Screenshots
Identical to Hyprland: wpctl for audio, brightnessctl for brightness, playerctl for media, grim+slurp for screenshots.

## Waybar Changes

- `modules-left`: `"hyprland/workspaces"` → `"ext/workspaces"`
- Module config block: rename key and update options to `ext/workspaces` equivalents (`format`, `on-click`, `sort-by-number` remain the same)
- All other waybar config (clock, cpu, memory, pulseaudio, network, battery, style) unchanged

## Hyprland Block

`wayland.windowManager.hyprland.enable = false` — full config kept in place for easy re-enable if needed.

## Success Criteria

- `home-manager switch` completes without errors
- MangoWC starts with waybar and wallpaper on login
- Kitty opens on SUPER+Q
- Rofi launches on SUPER+D
- Workspaces 1–10 switch correctly in waybar
- All media/brightness keys work
- Layout switching keybinds cycle through master/grid/monocle/deck
