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
  networking.hostName = "wavedash";

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Configure keymap in X11
  services.xserver.layout = "us";

  # sound.enable = true;
  hardware.pulseaudio.enable = false;

  # User info
  programs.fish.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  users.users.nyadiia = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "libvirtd" ];
    home = "/home/nyadiia";
    shell = pkgs.fish;
    # !! please use home-manager if you can !!
    packages = with pkgs; [
      signal-desktop
      any-nix-shell
      steam
      obsidian
      element-desktop
      spotify
      pinentry
    ];
    openssh.authorizedKeys.keyFiles = [ ssh-keys.outPath ];
  };

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];

  # Enable GPG
  programs.gnupg.agent.enable = true;

  # GNOME
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  ## run x by default
  services.xserver.displayManager.defaultSession = "gnome-xorg";
  security.pam.services.gdm.enableGnomeKeyring = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

