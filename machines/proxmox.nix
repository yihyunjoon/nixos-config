{ ... }:
{
  imports = [
    ../modules/common.nix
    ./proxmox-hardware.nix
    ../users/yihyunjoon/proxmox.nix
  ];

  services.openssh.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
