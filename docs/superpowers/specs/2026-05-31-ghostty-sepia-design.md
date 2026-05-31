# Ghostty Terminal — Sepia Monochrome Theme

**Date:** 2026-05-31  
**File:** `home.nix` → `xdg.configFile."ghostty/config".text`

## Summary

Apply a single deep sepia ink color (`#2e1a08`) to all terminal text — foreground, cursor, and all 16 ANSI palette entries. Selection gets a parchment amber highlight for visibility. Background opacity stays at `0` (transparent, wallpaper shows through).

## Changes

All additions to the existing `xdg.configFile."ghostty/config".text` block:

| Setting | Value | Notes |
|---|---|---|
| `foreground` | `#2e1a08` | All text |
| `cursor-color` | `#2e1a08` | Cursor block |
| `selection-background` | `#c8a96e` | Amber highlight on select |
| `selection-foreground` | `#2e1a08` | Text color inside selection |
| `palette = 0` through `palette = 15` | `#2e1a08` | All 16 ANSI colors identical |
| `background-opacity` | `0` | Unchanged |

## Out of Scope

- Kitty terminal (not in use)
- Font changes
- Any other Ghostty settings
