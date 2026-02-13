{
  description = "NixOS 25.11 with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      hmModule = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.yihyunjoon = import ./users/yihyunjoon/home.nix;
      };
    in
    {
      nixosConfigurations.proxmox = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/proxmox.nix
          home-manager.nixosModules.home-manager
          hmModule
        ];
      };

      nixosConfigurations.orbstack = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./machines/orbstack.nix
          home-manager.nixosModules.home-manager
          hmModule
        ];
      };
    };
}
