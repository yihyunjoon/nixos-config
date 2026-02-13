{ config, pkgs, ... }:
{
  home.username = "yihyunjoon";
  home.homeDirectory = "/home/yihyunjoon";

  home.packages = with pkgs; [
    bat
    eza
    fd
    fzf
    gh
    htop
    jq
    ripgrep
  ];

  programs.git = {
    enable = true;
    userName = "Yi Hyunjoon";
    userEmail = "yi.hyunjoon@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  xdg.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      l = "eza -al";
      nv = "nvim";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
  };

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
  };

  home.stateVersion = "25.11";
}
