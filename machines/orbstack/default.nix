{ pkgs, lib, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./orbstack.nix
    ../../users/yihyunjoon/orbstack.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Asia/Seoul";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  programs.nix-ld.enable = true;
  programs.zsh.enable = true;

  networking.hostName = "nixos";

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

  system.stateVersion = "25.11";
}
