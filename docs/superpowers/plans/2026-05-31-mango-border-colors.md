# MangoWC Border Colors Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Change the two MangoWC border color values in `home.nix` to match the parchment palette.

**Architecture:** Single edit to the `xdg.configFile."mango/config.conf".text` Nix string in `home.nix`. No other files touched.

**Tech Stack:** Nix/home-manager. Apply with `sudo nixos-rebuild switch --flake /home/bugzy/.config/nixos#nixos`.

---

## Files

- **Modify:** `/home/bugzy/.config/nixos/home.nix` — two lines inside `xdg.configFile."mango/config.conf".text`

---

## Task 1: Update border colors

**Files:**
- Modify: `/home/bugzy/.config/nixos/home.nix`

- [ ] **Step 1: Edit the two color lines**

  Find these two lines inside the `xdg.configFile."mango/config.conf".text` block:

  ```
  focuscolor=0xffffffff
  bordercolor=0x262625ff
  ```

  Replace them with:

  ```
  focuscolor=0xc8a96eff
  bordercolor=0x7a5030ff
  ```

- [ ] **Step 2: Commit**

  ```bash
  cd /home/bugzy/.config/nixos
  git add home.nix
  git commit -m "feat: update mango border colors to parchment palette"
  ```

- [ ] **Step 3: Apply and verify**

  ```bash
  sudo nixos-rebuild switch --flake /home/bugzy/.config/nixos#nixos
  ```

  Expected: focused window border turns warm amber (`#c8a96e`), unfocused turns dark oak (`#7a5030`).
