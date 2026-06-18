# nixos-config
<img width="1920" height="1080" alt="20260618_142906" src="https://github.com/user-attachments/assets/31486455-0102-44a4-8151-601cbd422ad1" />


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
nixos/
├── flake.nix               # Inputs (nixos-unstable + home-manager) + per-host outputs
├── flake.lock              # Pinned input revisions — reproducible across machines
├── configuration.nix       # Shared system config: boot, networking, fonts, greetd
├── home.nix                # Shared user config: packages, kitty, waybar, mangowc, git
└── hosts/
    └── nixos/              # Per-machine config
        ├── default.nix     # hostname + hardware-specific bits (e.g. WiFi driver)
        └── hardware-configuration.nix
```

Anything hardware-bound (disk UUIDs, WiFi drivers, hostname) lives under
`hosts/<name>/`; everything shared lives at the top level. Home Manager is
integrated as a NixOS module, so a single command applies everything.

## Applying changes

```bash
sudo nixos-rebuild switch --flake ~/.config/nixos#nixos
```

## Adding a new machine

1. On the new machine, generate its hardware config:
   ```bash
   nixos-generate-config --show-hardware-config > nixos/hosts/<name>/hardware-configuration.nix
   ```
2. Create `nixos/hosts/<name>/default.nix` (copy `hosts/nixos/default.nix`, set
   `networking.hostName = "<name>";` and adjust any hardware-specific options).
3. Register it in `flake.nix` under `nixosConfigurations`:
   ```nix
   <name> = mkHost "<name>";
   ```
4. Build it: `sudo nixos-rebuild switch --flake ~/.config/nixos#<name>`
