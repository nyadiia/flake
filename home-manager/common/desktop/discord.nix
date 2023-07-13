{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.override { 
          src = builtins.fetchTarball https://discord.com/api/download?platform=linux&format=tar.gz;
          withOpenASAR = true;
          withVencord = true;
        };
    }
    )
  ];

  home.packages = with pkgs; [
    discord
  ];
}
