{ pkgs, config, ... }:

{
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
}