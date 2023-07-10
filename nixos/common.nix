{ inputs, config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Fonts config
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs;  [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      font-awesome
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "FiraCode Nerd Font" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    tailscale
    git
    delta
  ];

  # remember to login to tailscale!! sorry this isn't declaritive but i'm not putting api keys on github :)
  services.tailscale.enable = true;
  # networking.firewall = {
  #   # enable the firewall
  #   enable = true;

  #   # always allow traffic from your Tailscale network
  #   trustedInterfaces = [ "tailscale0" ];

  #   # allow the Tailscale UDP port through the firewall
  #   allowedUDPPorts = [ config.services.tailscale.port ];

  #   # allow you to SSH in over the public internet
  #   networking.firewall.allowedTCPPorts = [ 22 ];
  # };


  services.dbus.enable = true;
  services.dbus.packages = with pkgs; [ dconf ];
  programs.dconf.enable = true;

  # Allow nonfree software
  nixpkgs.config.allowUnfree = true;
}
