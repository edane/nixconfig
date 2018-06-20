{ config, lib, pkgs, ... }:

with lib;

{
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.nixos.stateVersion = "17.09";

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak-sv-a1";
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "all"
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;

  # Enable fish
  programs.fish.enable = true;
  programs.mosh.enable = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    ag
    ccid              # Used for smartcards
    curl
    dnsutils
    emacs
    file
    fzf
    git
    gnupg
    htop
    host
    ncdu
    nfs-utils
    oathToolkit       # Used by the pass otp etxension
    pass
    pv
    stow
    sshfs-fuse
    tmux
    youtube-dl
    whois
    python36
  ];

  # Enable firewall.
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  # Define a user account.
  users.extraUsers.concate.isNormalUser = true;
  users.extraUsers.concate.uid = 1000;
  users.extraUsers.concate.extraGroups = [ "wheel" ];
}
