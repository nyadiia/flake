# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    };
  nixpkgs.hostPlatform.system = "x86_64-linux";
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.initrd.availableKernelModules = [ "i915" ];
  # boot.initrd.kernelModules = [ "i915" ];

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.hostName = "wavedash";

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

  # Allow nonfree software
  nixpkgs.config.allowUnfree = true;

  # Magic incantations for hardware video acceleration
  # hardware.opengl = {
  #     enable = true;
  #     driSupport = true;
  #     extraPackages = with pkgs; [
  #       vaapiIntel
  #       vaapiVdpau
  #       libvdpau-va-gl
  #     ];
  # };

  services.dbus.enable = true;
  services.dbus.packages = with pkgs; [ dconf ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Fonts config

  fonts = {
      enableDefaultFonts = true;
      fonts = with pkgs;  [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        fira-code
        fira-code-symbols
        mplus-outline-fonts.githubRelease
        dina-font
        proggyfonts
        font-awesome
        cascadia-code
      ];
      fontconfig = {
        defaultFonts = {
          serif = [ "Noto Serif" ];
          sansSerif = [ "Noto Sans" ];
          monospace = [ "Fira Code" ];
        };
      };
  };

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
  };

  # Tailscale
  services.tailscale.enable = true;

  # sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).

  programs.fish.enable = true;
  users.users.nyadiia = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" ];
      home = "/home/nyadiia";
      shell = pkgs.fish;
      packages = with pkgs; [
        # firefox
        # thunderbird
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH7rQ+JsT9CDMUgnNyOv6qyHb1YMURt+eyT3l9R7IzbJ"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQ/o4YWuzG7q/p+/3RQ1JeMsa0Jp7bHjAeNpYgRTl6b"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHIhPVxuL0Fmv0GdW1QIvMy8kbCKuLD2z7Y2baa7ImdO"
      ];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    nano
    gnome.gnome-tweaks
    gnomeExtensions.user-themes
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.dconf.enable = true;


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
  system.stateVersion = "22.05"; # Did you read the comment?

}

