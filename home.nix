{ config, pkgs, inputs, ... }:

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
    ghostty
    pavucontrol
    vscode
    discord
    audacity
    blender
    obs-studio
    godot
    wl-clipboard
    kdePackages.dolphin
    kitty
    unzip
    unrar
    waybar
    kew
    nodejs
    pkg-config
    openssl
    libimobiledevice
    usbmuxd
    glib
    gtk3
    webkitgtk_4_1
    gsettings-desktop-schemas
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
    cmatrix
    cava
    ripgrep
    fd
    gcc
    lazygit
    grim
    slurp
    appimage-run
    usbmuxd
    openssl
    python3
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

      modules-left = [ "ext/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "cpu" "custom/sep" "memory" "custom/sep" "pulseaudio" "custom/sep" "network" "custom/sep" "battery" ];

      "ext/workspaces" = {
        format = "{name}";
        on-click = "activate";
        sort-by-number = true;
      };

      clock = {
        format = "{:%H:%M}";
        format-alt = "{:%a, %b %d}";
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

      "custom/sep" = {
        format = "·";
        interval = "once";
        tooltip = false;
      };
    }];

    style = ''
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
    '';
  };

      
  # ── Ghostty ───────────────────────────────────────────────────────────────
  xdg.configFile."ghostty/config".text = ''
    background-opacity = 0
  '';

  # ── MangoWC ───────────────────────────────────────────────────────────────
  xdg.configFile."mango/config.conf".text = ''
    exec-once=waybar
    exec-once=swaybg -i /home/bugzy/Pictures/wallpapers/nixos.png -m fill

    env=XCURSOR_THEME,Bibata-Modern-Classic
    env=XCURSOR_SIZE,24

    # Gaps
    gappih=5
    gappiv=5
    gappoh=20
    gappov=20

    # Borders
    borderpx=2
    focuscolor=0xffffffff
    bordercolor=0x262625ff

    # Decoration
    border_radius=5
    blur=10
    blur_params_num_passes=4
    blur_params_radius=3
    shadows=1
    shadows_size=4
    shadowscolor=0x1a1a1aff

    # Animations
    animations=1

    # Input
    xkb_rules_layout=us
    sloppyfocus=1
    trackpad_natural_scrolling=0
    cursor_size=24

    bind=SUPER,r,reload_config
    bind=SUPER,q,spawn,ghostty
    bind=SUPER,c,killclient
    bind=SUPER,m,quit
    bind=SUPER,e,spawn,dolphin
    bind=SUPER,v,togglefloating
    bind=SUPER,d,spawn,rofi -show drun
    bind=SUPER,f,togglefullscreen

    bind=SUPER,left,focusdir,left
    bind=SUPER,right,focusdir,right
    bind=SUPER,up,focusdir,up
    bind=SUPER,down,focusdir,down

    bind=SUPER+SHIFT,t,setlayout,master
    bind=SUPER+SHIFT,g,setlayout,grid
    bind=SUPER+SHIFT,m,setlayout,monocle
    bind=SUPER+SHIFT,d,setlayout,deck
    bind=SUPER+SHIFT,r,setlayout,scroller

    bind=SUPER,1,view,1,0
    bind=SUPER,2,view,2,0
    bind=SUPER,3,view,3,0
    bind=SUPER,4,view,4,0
    bind=SUPER,5,view,5,0
    bind=SUPER,6,view,6,0
    bind=SUPER,7,view,7,0
    bind=SUPER,8,view,8,0
    bind=SUPER,9,view,9,0
    bind=SUPER,0,view,10,0

    bind=SUPER+SHIFT,1,tag,1,0
    bind=SUPER+SHIFT,2,tag,2,0
    bind=SUPER+SHIFT,3,tag,3,0
    bind=SUPER+SHIFT,4,tag,4,0
    bind=SUPER+SHIFT,5,tag,5,0
    bind=SUPER+SHIFT,6,tag,6,0
    bind=SUPER+SHIFT,7,tag,7,0
    bind=SUPER+SHIFT,8,tag,8,0
    bind=SUPER+SHIFT,9,tag,9,0
    bind=SUPER+SHIFT,0,tag,10,0

    bind=SUPER,s,toggle_scratchpad
    bind=SUPER+SHIFT,s,toggle_scratchpad

    axisbind=SUPER,DOWN,viewtoright_have_client
    axisbind=SUPER,UP,viewtoleft_have_client

    mousebind=SUPER,btn_left,moveresize,curmove
    mousebind=SUPER,btn_right,moveresize,curresize

    bind=NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
    bind=NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bind=NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bind=NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bind=NONE,XF86MonBrightnessUp,spawn,brightnessctl -e4 -n2 set 5%+
    bind=NONE,XF86MonBrightnessDown,spawn,brightnessctl -e4 -n2 set 5%-

    bindl=NONE,XF86AudioNext,spawn,playerctl next
    bindl=NONE,XF86AudioPause,spawn,playerctl play-pause
    bindl=NONE,XF86AudioPlay,spawn,playerctl play-pause
    bindl=NONE,XF86AudioPrev,spawn,playerctl previous

    bind=NONE,Print,spawn_shell,mkdir -p ~/Pictures/screenshots && grim ~/Pictures/screenshots/$(date +%Y%m%d_%H%M%S).png
    bind=SUPER,Print,spawn_shell,mkdir -p ~/Pictures/screenshots && grim -g "$(slurp)" ~/Pictures/screenshots/$(date +%Y%m%d_%H%M%S).png
  '';
}
