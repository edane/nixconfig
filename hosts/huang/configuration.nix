# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../profiles/common.nix
      ../../profiles/common-graphical.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "huang";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    emacs

    evince
    gnome3.gnome-tweak-tool
    gnomeExtensions.dash-to-dock
    gnomeExtensions.topicons-plus
  ];

  # Enable nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  # Ugly hack to get gdm and gnome to understand keyboard settings
  # https://github.com/NixOS/nixpkgs/issues/14318#issuecomment-330193990
  services.xserver.desktopManager.gnome3.extraGSettingsOverrides = ''
    [org.gnome.desktop.input-sources]
    sources=[('xkb', 'se+dvorak')]
    xkb-options=['eurosign:e', 'ctrl:nocaps', 'numpad:mac', 'kpdl:dot']
  '';

  # Enable Gnome3.
  services.xserver.desktopManager.gnome3.enable = true;

  # Enable autologin.
  services.xserver.displayManager.sddm.enable = false;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.autoLogin.enable = true;
  services.xserver.displayManager.gdm.autoLogin.user = "concate";
}
