{ pkgs, ... }:

{
  # Install home-manager
  programs.home-manager.enable = true;
  programs.home-manager.path = https://github.com/rycee/home-manager/archive/master.tar.gz;

  home.file = [
    # Nano config
    {
      target = ".nanorc";
      text = ''
      set const	    # Show linenumbers -c as default
      '';
    }

    # Mpv config file
    {
      target = ".config/mpv/mpv.conf";
      text = ''
      # Don't show images embedded in music files
      no-audio-display
      '';
    }

    # Tmux config
    { target = ".tmux.conf"; source = ./dotfiles/tmux.conf; }

    # Htop
    { target = ".config/htop/htoprc"; source = ./dotfiles/htop/htoprc; }

    # Stupidterm
    { target = ".config/stupidterm.ini"; source = ./dotfiles/stupidterm.ini; }
  ];

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs._0blayout
      epkgs.diff-hl
      epkgs.flycheck
      epkgs.guide-key
      epkgs.magit
      epkgs.nix-mode
      epkgs.use-package
      epkgs.web-mode
      epkgs.webpaste
      epkgs.zerodark-theme
    ];
  };

  programs.git = {
    enable = true;
    userName = "Caroline Hirwing";
    userEmail = "caroline@hirwing.se";
  };

  programs.browserpass.enable = true;

  manual.manpages.enable = false;
}


