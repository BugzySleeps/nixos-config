# nixos-config
<img width="1365" height="768" alt="20260531_154149" src="https://github.com/user-attachments/assets/2c6b05e1-2187-4af8-a2e0-56483e41cd8c" />

My NixOS configuration — Mangowc DE on nixos.

## Stack

| Component | Choice |
|---|---|
| WM | Mangowc (Wayland Compositor) |
| Bar | Waybar |
| Terminal | Kitty |
| Launcher | Rofi |
| File manager | Dolphin |
| Display manager | greetd |
| Wallpaper | swaybg |
| Cursor | Bibata Modern Classic |

## Structure

```
.
├── flake.nix               # Inputs: nixos-unstable + home-manager
├── flake.lock
├── configuration.nix       # System config: boot, networking, fonts, greetd
├── hardware-configuration.nix
└── home.nix                # User config: packages, kitty, waybar, mangowc, git
```

Home Manager is integrated as a NixOS module, so a single command applies everything.

## Applying changes

```bash
sudo nixos-rebuild switch --flake ~/.config/nixos#nixos
```
