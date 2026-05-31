{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # ── Boot ──────────────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ];
  boot.kernelModules = [ "8821ce" ];
  boot.blacklistedKernelModules = [ "rtw88_8821ce" "rtw88_pci" "rtw88_core" ];

  # ── Networking ────────────────────────────────────────────────────────────
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # ── Locale & Time ─────────────────────────────────────────────────────────
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT    = "en_US.UTF-8";
    LC_MONETARY       = "en_US.UTF-8";
    LC_NAME           = "en_US.UTF-8";
    LC_NUMERIC        = "en_US.UTF-8";
    LC_PAPER          = "en_US.UTF-8";
    LC_TELEPHONE      = "en_US.UTF-8";
    LC_TIME           = "en_US.UTF-8";
  };

  # ── Keymap ────────────────────────────────────────────────────────────────
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # ── User ──────────────────────────────────────────────────────────────────
  users.users.bugzy = {
    isNormalUser = true;
    description = "Bugzy";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # ── Home Manager ──────────────────────────────────────────────────────────
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.bugzy = import ./home.nix;
  };

  # ── Packages (system-level only) ──────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    mangowc
  ];

  # ── Fonts ─────────────────────────────────────────────────────────────────
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono
  ];

  # ── Nix settings ──────────────────────────────────────────────────────────
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ── Programs ──────────────────────────────────────────────────────────────
  programs.hyprland.enable = true;
  programs.mangowc.enable = true;

  # ── iOS sideloading ───────────────────────────────────────────────────────
  services.usbmuxd.enable = true;

  # ── Display Manager ───────────────────────────────────────────────────────
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "mango";
      user = "bugzy";
    };
  };

  system.stateVersion = "25.11";
}
