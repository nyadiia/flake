{ config, pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };
}