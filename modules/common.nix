{ pkgs, ... }:
{
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

  system.stateVersion = "25.11";
}
