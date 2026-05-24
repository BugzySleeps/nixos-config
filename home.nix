{ config, pkgs, ... }:

{
  home.username = "bugzy";
  home.homeDirectory = "/home/bugzy";
  home.stateVersion = "25.11";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # ── Packages ─────────────────────────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    firefox
    kdePackages.dolphin
    kitty
    waybar
    vim
    wget
    git
    hyprpaper
    hyprcursor
    bibata-cursors
    papirus-icon-theme
    rofi
    bluez
    blueman
    playerctl
    brightnessctl
    jetbrains-mono
    swaybg
    claude-code
    fastfetch
    neovim
    ripgrep
    fd
    gcc
    lazygit
    grim
    slurp
  ];

  # ── Shell ─────────────────────────────────────────────────────────────────
  programs.bash = {
    enable = true;
    initExtra = "fastfetch";
  };

  # ── Git ───────────────────────────────────────────────────────────────────
  programs.git = {
    enable = true;
    settings = {
      user.name = "Bugzymp4";
      user.email = "bugzyrecordz@gmail.com";
      init.defaultBranch = "master";
    };
  };

  # ── Kitty ─────────────────────────────────────────────────────────────────
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.5";

      # Cherry blossom palette — matches wallpaper + Hyprland border pinks
      background           = "#0c0c0c";
      foreground           = "#e0d0d8";
      cursor               = "#ff3c82";
      cursor_text_color    = "#0c0c0c";
      selection_background = "#c4006a";
      selection_foreground = "#e0d0d8";

      # Black
      color0  = "#0c0c0c";
      color8  = "#3d1a27";

      # Red → deep blossom pink
      color1  = "#c4006a";
      color9  = "#ff3c82";

      # Green → warm rose
      color2  = "#a06080";
      color10 = "#d090a8";

      # Yellow → blush
      color3  = "#c87090";
      color11 = "#f0a8c0";

      # Blue → dusk purple
      color4  = "#7060a0";
      color12 = "#9080c0";

      # Magenta → hot pink
      color5  = "#ff3c82";
      color13 = "#ff80b0";

      # Cyan → mauve
      color6  = "#9060a0";
      color14 = "#c090c8";

      # White
      color7  = "#c8b8c0";
      color15 = "#ece0e8";
    };
  };

  # ── Waybar ────────────────────────────────────────────────────────────────
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 32;
      margin-top = 8;
      margin-left = 12;
      margin-right = 12;
      spacing = 4;

      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "cpu" "memory" "pulseaudio" "network" "battery" ];

      "hyprland/workspaces" = {
        format = "{name}";
        on-click = "activate";
        sort-by-number = true;
      };

      clock = {
        format = " {:%H:%M}";
        format-alt = " {:%a, %b %d}";
        tooltip-format = "<tt>{calendar}</tt>";
      };

      cpu = {
        interval = 5;
        format = " {usage}%";
        max-length = 10;
      };

      memory = {
        interval = 10;
        format = " {used:0.1f}G";
        max-length = 10;
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = " muted";
        format-icons.default = [ "" "" "" ];
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +2%";
        on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -2%";
      };

      network = {
        format-wifi = " {signalStrength}%";
        format-ethernet = " eth";
        format-disconnected = "睊 off";
        tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ipaddr}";
        tooltip-format-disconnected = "Disconnected";
        max-length = 20;
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        tooltip-format = "{timeTo}";
      };
    }];

    style = ''
      * {
          font-family: "JetBrains Mono", "Fira Code", monospace;
          font-size: 12px;
          font-weight: 500;
          border: none;
          border-radius: 0;
          min-height: 0;
      }

      window#waybar {
          background: transparent;
      }

      .modules-left,
      .modules-center,
      .modules-right {
          background: rgba(20, 20, 28, 1);
          border-radius: 12px;
          padding: 0 8px;
          margin: 4px 0;
      }

      #workspaces,
      #clock,
      #cpu,
      #memory,
      #pulseaudio,
      #network,
      #battery {
          color: #cdd6f4;
          padding: 0 8px;
          margin: 2px 1px;
          border-radius: 8px;
          transition: background 0.2s ease, color 0.2s ease;
      }

      #workspaces button {
          color: #6c7086;
          padding: 0 6px;
          border-radius: 8px;
          transition: all 0.15s ease;
          background: transparent;
      }

      #workspaces button.active {
          color: #cba6f7;
          background: rgba(203, 166, 247, 0.15);
      }

      #workspaces button:hover {
          color: #cdd6f4;
          background: rgba(255,255,255,0.08);
      }

      #clock {
          color: #89dceb;
          font-weight: 600;
          letter-spacing: 0.04em;
      }

      #clock:hover { background: rgba(137, 220, 235, 0.1); }

      #cpu { color: #a6e3a1; }
      #cpu.warning { color: #f9e2af; }
      #cpu.critical { color: #f38ba8; animation: pulse 1s infinite; }

      #memory { color: #89b4fa; }

      #pulseaudio { color: #f5c2e7; }
      #pulseaudio.muted { color: #585b70; }

      #network { color: #94e2d5; }
      #network.disconnected { color: #f38ba8; }

      #battery { color: #a6e3a1; }
      #battery.warning { color: #f9e2af; }
      #battery.critical { color: #f38ba8; }
      #battery.charging { color: #a6e3a1; }

      @keyframes pulse {
          0%   { opacity: 1; }
          50%  { opacity: 0.5; }
          100% { opacity: 1; }
      }
    '';
  };

  # ── Hyprland ──────────────────────────────────────────────────────────────
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    extraConfig = ''
      monitor=,preferred,auto,auto

      $terminal = kitty
      $fileManager = dolphin
      $menu = rofi -show drun

      exec-once = waybar
      exec-once = swaybg -i /home/bugzy/Pictures/wallpapers/nixos.png -m fill

      env = XCURSOR_THEME,Bibata-Modern-Classic
      env = XCURSOR_SIZE,24

      general {
          gaps_in = 5
          gaps_out = 20
          border_size = 2
          col.active_border = rgba(ff3c82ee) rgba(c4006aee) 45deg
          col.inactive_border = rgba(3d1a27aa)
          resize_on_border = false
          allow_tearing = false
          layout = dwindle
      }

      decoration {
          rounding = 10
          rounding_power = 2
          active_opacity = 1
          inactive_opacity = 1

          shadow {
              enabled = true
              range = 4
              render_power = 3
              color = rgba(1a1a1aee)
          }

          blur {
              enabled = true
              size = 3
              passes = 1
              vibrancy = 0.1696
          }
      }

      animations {
          enabled = yes, please :)

          bezier = easeOutQuint,   0.23, 1,    0.32, 1
          bezier = easeInOutCubic, 0.65, 0.05, 0.36, 1
          bezier = linear,         0,    0,    1,    1
          bezier = almostLinear,   0.5,  0.5,  0.75, 1
          bezier = quick,          0.15, 0,    0.1,  1

          animation = global,        1, 10,  default
          animation = border,        1, 5.39,  easeOutQuint
          animation = windows,       1, 4.79,  easeOutQuint
          animation = windowsIn,     1, 4.1,   easeOutQuint, popin 87%
          animation = windowsOut,    1, 1.49,  linear,       popin 87%
          animation = fadeIn,        1, 1.73,  almostLinear
          animation = fadeOut,       1, 1.46,  almostLinear
          animation = fade,          1, 3.03,  quick
          animation = layers,        1, 3.81,  easeOutQuint
          animation = layersIn,      1, 4,     easeOutQuint, fade
          animation = layersOut,     1, 1.5,   linear,       fade
          animation = fadeLayersIn,  1, 1.79,  almostLinear
          animation = fadeLayersOut, 1, 1.39,  almostLinear
          animation = workspaces,    1, 1.94,  almostLinear, fade
          animation = workspacesIn,  1, 1.21,  almostLinear, fade
          animation = workspacesOut, 1, 1.94,  almostLinear, fade
          animation = zoomFactor,    1, 7,     quick
      }

      dwindle {

          preserve_split = true
      }

      master {
          new_status = master
      }

      misc {
          force_default_wallpaper = 0
          disable_hyprland_logo = true
      }

      input {
          kb_layout = us
          follow_mouse = 1
          sensitivity = 0
          touchpad {
              natural_scroll = false
          }
      }

      gesture = 3, horizontal, workspace


      $mainMod = SUPER

      bind = $mainMod, Q, exec, $terminal
      bind = $mainMod, C, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, D, exec, $menu
      bind = $mainMod, P, pseudo,

      bind = $mainMod, F, fullscreen

      bind = $mainMod, left,  movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up,    movefocus, u
      bind = $mainMod, down,  movefocus, d

      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      bind = $mainMod,       S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up,   workspace, e-1

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      bindel = , XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
      bindel = , XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindel = , XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = , XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindel = , XF86MonBrightnessUp,   exec, brightnessctl -e4 -n2 set 5%+
      bindel = , XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

      bindl = , XF86AudioNext,  exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay,  exec, playerctl play-pause
      bindl = , XF86AudioPrev,  exec, playerctl previous

      bind = , Print,          exec, mkdir -p ~/Pictures/screenshots && grim ~/Pictures/screenshots/$(date +%Y%m%d_%H%M%S).png
      bind = $mainMod, Print,  exec, mkdir -p ~/Pictures/screenshots && grim -g "$(slurp)" ~/Pictures/screenshots/$(date +%Y%m%d_%H%M%S).png

    '';
  };
}
