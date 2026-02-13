{ lib, modulesPath, ... }:
{
  imports = [
    ../modules/common.nix
    ./orbstack-guest.nix
    ../users/yihyunjoon/orbstack.nix
    (modulesPath + "/virtualisation/lxc-container.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  systemd.network = {
    enable = true;
    networks."50-eth0" = {
      matchConfig.Name = "eth0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };

  security.sudo.wheelNeedsPassword = false;
  users.mutableUsers = false;
}
