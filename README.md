# nixos-config

Bugzy's NixOS configuration — Hyprland desktop on nixos-unstable with Home Manager.

## Stack

| Component | Choice |
|---|---|
| WM | Hyprland (Wayland) |
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
└── home.nix                # User config: packages, kitty, waybar, hyprland, git
```

Home Manager is integrated as a NixOS module, so a single command applies everything.

## Applying changes

```bash
sudo nixos-rebuild switch --flake ~/.config/nixos#nixos
```

To test without making it permanent (reverts on reboot):

```bash
sudo nixos-rebuild test --flake ~/.config/nixos#nixos
```

To update packages:

```bash
nix flake update ~/.config/nixos
```
