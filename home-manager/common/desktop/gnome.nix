{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-dock
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.fullscreen-avoider
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.user-themes

    gnome.gnome-tweaks

    papirus-icon-theme
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GTK_THEME = "Orchis-Pink-Dark-Compact";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Orchis-Pink-Dark-Compact";
      package = pkgs.orchis-theme.override {
        tweaks = [ "macos" "black" "compact" ];
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
      theme = "Orchis-Pink-Dark-Compact";
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "Vitals@CoreCoding.com"
        "fullscreen-avoider@noobsai.github.com"
        "sound-output-device-chooser@kgshank.net"
      ];
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "Orchis-Pink-Dark-Compact";
    };
  };
}
