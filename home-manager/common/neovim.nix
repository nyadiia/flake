{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # TODO: make this grab a neovim config from github
    #       preferrably i fork something for this
  };
}