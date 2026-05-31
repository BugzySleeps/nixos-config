# Waybar Medieval Theme Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restyle `programs.waybar` in `home.nix` to the Illuminated Scroll medieval theme — single parchment bar, Noto Serif font, sepia palette, "The Hour" clock label, middle-dot separators.

**Architecture:** All changes live in `/home/bugzy/.config/nixos/home.nix`. The `settings` block gains a `custom/sep` separator module and an updated `modules-right` list. The `style` block is fully replaced. A final optional task attempts an SVG noise texture and reverts cleanly if GTK doesn't render it.

**Tech Stack:** Nix/home-manager, waybar GTK CSS, NixOS flake (`sudo nixos-rebuild switch --flake /home/bugzy/.config/nixos#nixos`)

---

## Files

- **Modify:** `/home/bugzy/.config/nixos/home.nix`
  - `programs.waybar.settings[0].modules-right` — add `"custom/sep"` between each module
  - `programs.waybar.settings[0]."custom/sep"` — new module definition
  - `programs.waybar.style` — full replacement with parchment CSS

---

## Task 1: Replace the style block and add the separator module

**Files:**
- Modify: `/home/bugzy/.config/nixos/home.nix`

- [ ] **Step 1: Update `modules-right` and add `custom/sep` to the settings block**

  In `home.nix`, inside `programs.waybar.settings = [{...}]`, change:

  ```nix
  modules-right = [ "cpu" "memory" "pulseaudio" "network" "battery" ];
  ```

  to:

  ```nix
  modules-right = [ "cpu" "custom/sep" "memory" "custom/sep" "pulseaudio" "custom/sep" "network" "custom/sep" "battery" ];
  ```

  Then add the separator module definition inside the same settings block (alongside `clock`, `cpu`, etc.):

  ```nix
  "custom/sep" = {
    format = "·";
    interval = "once";
    tooltip = false;
  };
  ```

- [ ] **Step 2: Replace the entire `style = ''...''` block**

  Delete everything between `style = ''` and the closing `'';`, and replace with:

  ```css
  * {
      font-family: "Noto Serif", Georgia, serif;
      font-size: 12px;
      font-weight: 400;
      border: none;
      border-radius: 0;
      min-height: 0;
  }

  window#waybar {
      background-color: rgba(212, 188, 132, 0.92);
      border: 2px solid #7a5030;
      box-shadow: inset 0 0 0 1px rgba(90, 56, 32, 0.30);
      border-radius: 4px;
  }

  .modules-left,
  .modules-center,
  .modules-right {
      background: transparent;
      padding: 0 4px;
      margin: 0;
  }

  #workspaces,
  #clock,
  #cpu,
  #memory,
  #pulseaudio,
  #network,
  #battery,
  #custom-sep {
      color: #2e1a08;
      padding: 0 4px;
      margin: 2px 0;
      border-radius: 0;
      transition: background 0.15s ease, color 0.15s ease;
  }

  #workspaces button {
      color: rgba(46, 26, 8, 0.35);
      padding: 0 6px;
      border-radius: 2px;
      background: transparent;
      font-family: "Noto Serif", Georgia, serif;
      font-size: 12px;
      letter-spacing: 0.06em;
      transition: all 0.15s ease;
  }

  #workspaces button.active {
      color: #1e0e02;
      background: rgba(122, 80, 48, 0.22);
      font-weight: 700;
  }

  #workspaces button:hover {
      color: #2e1a08;
      background: rgba(122, 80, 48, 0.12);
  }

  #clock {
      font-size: 15px;
      font-weight: 700;
      letter-spacing: 0.06em;
      color: #1e0e02;
      padding: 0 8px;
  }

  #clock::before {
      content: "⸻ The Hour ⸻";
      display: block;
      font-size: 9px;
      font-style: italic;
      font-weight: 400;
      letter-spacing: 0.18em;
      opacity: 0.5;
      margin-bottom: 1px;
  }

  #custom-sep {
      color: rgba(46, 26, 8, 0.30);
      font-size: 10px;
      padding: 0 2px;
      min-width: 0;
  }

  #cpu { color: #2e1a08; }
  #cpu.warning { color: #8b5e2a; }
  #cpu.critical { color: #6b2a0a; animation: pulse 1s infinite; }

  #memory { color: #2e1a08; }

  #pulseaudio { color: #2e1a08; }
  #pulseaudio.muted { color: rgba(46, 26, 8, 0.40); }

  #network { color: #2e1a08; }
  #network.disconnected { color: rgba(46, 26, 8, 0.40); }

  #battery { color: #2e1a08; }
  #battery.warning { color: #8b5e2a; }
  #battery.critical { color: #6b2a0a; }
  #battery.charging { color: #3a2010; }

  @keyframes pulse {
      0%   { opacity: 1; }
      50%  { opacity: 0.5; }
      100% { opacity: 1; }
  }
  ```

- [ ] **Step 3: Apply the config**

  ```bash
  sudo nixos-rebuild switch --flake /home/bugzy/.config/nixos#nixos
  ```

  Expected: waybar reloads with a single parchment-colored strip, Noto Serif font, sepia text, separator dots between right-side modules, active workspace highlighted in warm tan.

- [ ] **Step 4: Commit**

  ```bash
  cd /home/bugzy/.config/nixos
  git add home.nix
  git commit -m "feat: apply medieval parchment theme to waybar"
  ```

---

## Task 2: Verify the clock label and apply fallback if needed

**Files:**
- Modify: `/home/bugzy/.config/nixos/home.nix` (only if fallback needed)

- [ ] **Step 1: Check the clock on the live bar**

  Look at the center of the bar. Two outcomes:

  **A — Label renders above the time** (`⸻ The Hour ⸻` on its own line above `14:23`): nothing to do, skip to Task 3.

  **B — Label is missing or appears inline** (e.g., `⸻ The Hour ⸻ 14:23` on one line, or no label at all): GTK did not honour `display: block` on `::before`. Apply the fallback below.

- [ ] **Step 2 (fallback only): Remove the `#clock::before` block from the CSS**

  Delete this entire block from the style:

  ```css
  #clock::before {
      content: "⸻ The Hour ⸻";
      display: block;
      font-size: 9px;
      font-style: italic;
      font-weight: 400;
      letter-spacing: 0.18em;
      opacity: 0.5;
      margin-bottom: 1px;
  }
  ```

- [ ] **Step 3 (fallback only): Change the clock format in the settings block**

  Change:

  ```nix
  clock = {
    format = "{:%H:%M}";
  ```

  to:

  ```nix
  clock = {
    format = "⸻ {:%H:%M}";
  ```

- [ ] **Step 4 (fallback only): Apply and verify**

  ```bash
  sudo nixos-rebuild switch --flake /home/bugzy/.config/nixos#nixos
  ```

  Expected: clock shows `⸻ 14:23` — decorative rule inline before the time.

- [ ] **Step 5 (fallback only): Commit**

  ```bash
  cd /home/bugzy/.config/nixos
  git add home.nix
  git commit -m "fix: use inline clock format fallback (GTK ::before unsupported)"
  ```

---

## Task 3: Attempt SVG parchment texture

**Files:**
- Modify: `/home/bugzy/.config/nixos/home.nix`

- [ ] **Step 1: Add SVG noise as `background-image` to `window#waybar`**

  Change the `window#waybar` block in the style from:

  ```css
  window#waybar {
      background-color: rgba(212, 188, 132, 0.92);
      border: 2px solid #7a5030;
      box-shadow: inset 0 0 0 1px rgba(90, 56, 32, 0.30);
      border-radius: 4px;
  }
  ```

  to:

  ```css
  window#waybar {
      background-color: rgba(212, 188, 132, 0.92);
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='300' height='300'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.75' numOctaves='4' stitchTiles='stitch'/%3E%3CfeColorMatrix type='saturate' values='0'/%3E%3C/filter%3E%3Crect width='300' height='300' filter='url(%23n)' opacity='0.08'/%3E%3C/svg%3E");
      background-size: 300px 300px;
      background-repeat: repeat;
      border: 2px solid #7a5030;
      box-shadow: inset 0 0 0 1px rgba(90, 56, 32, 0.30);
      border-radius: 4px;
  }
  ```

- [ ] **Step 2: Apply**

  ```bash
  sudo nixos-rebuild switch --flake /home/bugzy/.config/nixos#nixos
  ```

- [ ] **Step 3: Inspect the bar**

  Two outcomes:

  **A — Texture visible** (subtle grain/noise on the parchment surface): commit and done.

  ```bash
  cd /home/bugzy/.config/nixos
  git add home.nix
  git commit -m "feat: add SVG parchment noise texture to waybar"
  ```

  **B — No texture, bar looks identical to before**: GTK did not render the SVG data URI. Revert the three added lines (`background-image`, `background-size`, `background-repeat`) so `window#waybar` returns to:

  ```css
  window#waybar {
      background-color: rgba(212, 188, 132, 0.92);
      border: 2px solid #7a5030;
      box-shadow: inset 0 0 0 1px rgba(90, 56, 32, 0.30);
      border-radius: 4px;
  }
  ```

  Then apply and commit:

  ```bash
  sudo nixos-rebuild switch --flake /home/bugzy/.config/nixos#nixos
  cd /home/bugzy/.config/nixos
  git add home.nix
  git commit -m "revert: remove SVG texture (GTK data URI unsupported)"
  ```
