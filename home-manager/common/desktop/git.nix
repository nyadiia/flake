{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    delta.enable = true;
    userName = "Nadia Potteiger";
    userEmail = "nyadiia@pm.me";
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
    signing = {
      signByDefault = true;
      key = "C8DC17070AC33338193F9723229718FDC160E880";
    };
  };

  home.sessionVariables = {
    SSH_ASKPASS = "${pkgs.gnome.seahorse}/libexec/seahorse/ssh-askpass";
  };
}
