{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    delta.enable = true;
    difftastic.enable = true;
    userName = "Nadia Potteiger";
    userEmail = "nyadiia@pm.me";
    extraConfig = {
      core.editor = "nvim";
      credential.helper = "cache";
      init.defaultBranch = "main";
    };
    signing ={
      signByDefault = true;
      signingkey = "C8DC17070AC33338193F9723229718FDC160E880";
    };
  };
}