{ pkgs, ... }:
{
  users.users.yihyunjoon = {
    isNormalUser = true;
    description = "yihyunjoon";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      git
    ];
  };
}
