{
  description = "nyadiia flake!";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    hardware.url = "github:nixos/nixos-hardware";

    # this will be updated to https://nyadiia.dev/keys once i get to making that website real
    ssh-keys = {
      url = "https://github.com/nyadiia.keys";
      flake = false;
    };

    # spicetify-nix.url = github:the-argus/spicetify-nix;
  };

  outputs = { nixpkgs, home-manager, nixos-hardware, ... }@inputs: {
    overlays = {
      pkg-sets = (
        final: prev: {
          unstable = import inputs.unstable { system = final.system; };
        }
      );
    };
    nixosConfigurations = {
      # my desktop :3
      wavedash = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        modules = [
          ./nixos/wavedash/configuration.nix
          # nixos hardware for this specific system, most likely not needed but redundancy is everything
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-pc-hdd
          nixos-hardware.nixosModules.common-cpu-amd
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.nyadiia = import ./home-manager/wavedash/home.nix;
          }
        ];
      };
      hyprdash = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        modules = [
          ./nixos/hyprdash/configuration.nix
          nixos-hardware.nixosModules.framework
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.nyadiia = import ./home-manager/hyprdash/home.nix;
          }
        ];
      };
      crystal-heart = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/crystal-heart/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.nyadiia = import ./home-manager/crystal-heart/home.nix;
          }
        ];
      };
      # this will most likely be a temporary config as i get my configs working
      virtual-machine = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/virtual-machine/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.nyadiia = import ./home-manager/virtual-machine/home.nix;
          }
        ];
      };
      farewell = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/farewell/configuration.nix
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-cpu-intel
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.nyadiia = import ./home-manager/farewell/home.nix;
          }
        ];
      };
    };
  };
}
