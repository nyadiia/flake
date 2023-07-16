{ config, pkgs, ... }:

{
  nixpkgs.overlays =
  let
    vencord = self: super: {
      discord = super.discord.override { withOpenASAR = true; withVencord = true; };
    };
  in
  [ vencord ];

  home.packages = with pkgs; [
    discord
  ];
}
