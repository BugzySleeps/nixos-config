# ── Host: nixos ───────────────────────────────────────────────────────────
# Machine-specific config for this laptop. Everything here is hardware-bound
# and must NOT live in the shared ../../configuration.nix.
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos";

  # WiFi: Realtek RTL8821CE. Use the out-of-tree rtl8821ce driver and blacklist
  # the in-kernel rtw88 modules, which don't work reliably on this chip.
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ];
  boot.kernelModules = [ "8821ce" ];
  boot.blacklistedKernelModules = [ "rtw88_8821ce" "rtw88_pci" "rtw88_core" ];
}
