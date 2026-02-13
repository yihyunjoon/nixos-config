{ lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/lxc-container.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
