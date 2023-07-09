{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnome.gnome-tweaks
    papirus-icon-theme

    gnomeExtensions.user-themes
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-dock
    gnomeExtensions.fullscreen-avoider
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.user-themes
    gnomeExtensions.openweather
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
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
      clock-show-seconds = true;
      gtk-theme = "Orchis-Pink-Dark-Compact";
    };
    "org/gnome/desktop/wm/preferences" = {
      theme = "Orchis-Pink-Dark-Compact";
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 4;
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
        "openweather-extension@henslody.de"
      ];
      favorite-apps = [
        "librewolf.desktop"
        "org.gnome.Terminal.desktop"
        "org.gnome.Calendar.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Software.desktop"
        "codium.desktop"
        "md.obsidian.Obsidian.desktop"
        "org.signal.Signal.desktop"
        "com.discordapp.Discord.desktop"
        "im.riot.Riot.desktop"
        "com.spotify.Client.desktop"
      ];
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "Orchis-Pink-Dark-Compact";
    };
    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = "disabled";
      toggle-message-tray = "disabled";
      close = [ "<Super>q" ];
      maximize = "disabled";
      minimize = [ "<Super>comma" ];
      move-to-monitor-down = "disabled";
      move-to-monitor-left = "disabled";
      move-to-monitor-right = "disabled";
      move-to-monitor-up = "disabled";
      move-to-workspace-down = "disabled";
      move-to-workspace-up = "disabled";
      toggle-maximized = [ "<Super>m" ];
      unmaximize = "disabled";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "terminal super";
      command = "gnome-terminal";
      binding = "<Super>Return";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
  };
}
