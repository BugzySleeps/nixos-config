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
├── flake.nix               # Inputs: nixos-unstable + home-manager
├── flake.lock              # Pinned input revisions — reproducible across machines
├── configuration.nix       # System config: boot, networking, fonts, greetd
├── home.nix                # User config: packages, kitty, waybar, mangowc, git
└── hardware-configuration.nix   # Machine-specific (disk UUIDs, kernel modules)
```

`hardware-configuration.nix` is tracked (Nix flakes only see git-tracked
files), but it is machine-specific. On each machine, regenerate it locally —
that shows up as a local change, which Nix uses automatically. **Don't push
that change**, so the other machine keeps its own. Home Manager is integrated as
a NixOS module, so a single command applies everything.

## Applying changes

```bash
sudo nixos-rebuild switch --flake ~/.config/nixos#nixos
```

## Setting up on a new machine

```bash
git clone git@github.com:BugzySleeps/nixos-config.git ~/.config
# Overwrite with THIS machine's hardware config (don't reuse the committed one):
nixos-generate-config --show-hardware-config > ~/.config/nixos/hardware-configuration.nix
sudo nixos-rebuild boot --flake ~/.config/nixos#nixos && sudo reboot
```
