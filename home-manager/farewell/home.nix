{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    ../common
    ../common/server
  ];
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
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    neofetch
    bottom
  ];
}

