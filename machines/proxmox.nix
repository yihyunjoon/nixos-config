{ ... }:
{
  imports = [
    ../modules/common.nix
    ./proxmox-hardware.nix
    ../users/yihyunjoon/proxmox.nix
  ];

  networking.hostName = "nixos-proxmox";

  services.openssh.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
