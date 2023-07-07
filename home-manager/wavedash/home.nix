{ inputs, config, lib, pkgs, ... }:

with lib;
with pkgs;
let
  browser = [ "firefox.desktop" ];
  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/chrome" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "audio/*" = [ "vlc.desktop" ];
    "video/*" = [ "vlc.dekstop" ];
    #"image/*" = [ "ahoviewer.desktop" ];
    #"text/calendar" = [ "thunderbird.desktop" ]; # ".ics"  iCalendar format
    "application/json" = browser; # ".json"  JSON format
    "application/pdf" = browser; # ".pdf"  Adobe Portable Document Format (PDF)
  };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nyadiia";
  home.homeDirectory = "/home/nyadiia";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    (self:
      super: {
        discord = super.discord.overrideAttrs (
          _: { src = builtins.fetchTarball https://discord.com/api/download?platform=linux&format=tar.gz;
               withOpenASAR = true;
               withVencord = true;
            }
        );
      }
    )
  ];

   home.packages = with pkgs; [
    # commands
    lolcat
    neofetch
    bottom
    papirus-icon-theme
    firefox
    discord
    mpv
  ];

  # Git config
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Nadia Potteiger";
    userEmail = "nyadiia@pm.me";
    extraConfig = {
      core.editor = "nvim";
      credential.helper = "cache";
      init.defaultBranch = "main";
    };
  };

  #fzf
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  # vscode config
  programs.vscode = {
    enable = true;
  };

  home.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        GTK_THEME = "Nordic-darker";
  }; 
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/wm/preferences" = {
      theme = "Catppuccin-Mocha";
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" ];
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "Catppuccin-Mocha";
    };
  };

}

