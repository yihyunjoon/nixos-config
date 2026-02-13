{ pkgs, ... }:
{
  users.users.yihyunjoon = {
    uid = 501;
    extraGroups = [ "wheel" "orbstack" ];

    isSystemUser = true;
    group = "users";
    createHome = true;
    home = "/home/yihyunjoon";
    homeMode = "700";
    useDefaultShell = true;
    shell = pkgs.zsh;
    packages = with pkgs; [
      git
    ];
  };
}
