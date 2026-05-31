<img width="1920" height="1080" alt="nixos" src="https://github.com/user-attachments/assets/595a2361-a84e-43f2-80ae-8a1d8aa75566" />
# nixos-config

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
