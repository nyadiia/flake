{ pkgs, config, lib, ... }:

{
  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.zoxide.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      s = "ssh";
      cl = "clear";
      cd = "z";
    };
    interactiveShellInit = ''
      any-nix-shell fish --info-right | source
    '';
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      package.disabled = false;
      username = {
        show_always = true;
        style_user = "#FF0066";
        style_root = "#c061cb";
      };
      character = {
        success_symbol = "[❯](#FF0066)";
        error_symbol = "[✗](#ff4879)";
      };
      nix_shell = {
        disabled = false;
      };
    };
  };
}
