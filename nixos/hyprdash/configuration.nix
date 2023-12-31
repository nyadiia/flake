# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

let
  inherit (inputs) ssh-keys;
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common.nix
      ../ssh.nix
    ];

  nixpkgs.hostPlatform.system = "x86_64-linux";
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;
  networking.hostName = "hyprdash";

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # sound.enable = true;
  hardware.pulseaudio.enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent.enable = true;

  # User info
  programs.fish.enable = true;

  nixpkgs.overlays =
    let
      vencord = self: super: {
        discord = super.discord.override { withOpenASAR = true; withVencord = true; };
      };
    in
    [ vencord ];

  # environment.sessionVariables = {
  #   NIXOS_OZONE_WL = "1"; # Most Electron Applications
  #   USE_WAYLAND = "1"; # ArmCord
  # };

  users.users.nyadiia = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "libvirtd" ];
    home = "/home/nyadiia";
    shell = pkgs.fish;
    # !! please use home-manager if you can !!
    packages = with pkgs; [
      signal-desktop
      any-nix-shell
      obsidian
      cinny-desktop
      spotify
      nixpkgs-fmt
      discord
      tigervnc
      prismlauncher
    ];
    openssh.authorizedKeys.keyFiles = [ ssh-keys.outPath ];
  };
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1u"
  ];
  # GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome = {
    enable = true;
    ## enable fractional scaling on wayland
    extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Enable fingerprint
  services.fprintd = {
    enable = true;
    # tod.enable = true;
    # tod.driver = pkgs.libfprint-2-tod1-goodix;
  };

  # Enable Framework firmware updates
  services.fwupd.enable = true;

  # Enable virtualization
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];

  # environment.gnome.excludePackages = (with pkgs; [ 
  # gnome-photos gnome-tour
  #   ]) ++ (with pkgs.gnome; [
  # gnome-music
  # gedit
  # epiphany
  # geary
  # evince
  # gnome-characters
  # totem
  # tali
  # iagno
  # hitori
  # atomix
  #   ]);

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

