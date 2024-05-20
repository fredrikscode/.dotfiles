{ config, libs, inputs, pkgs, userSettings, ... }:

{

  imports = [
    ./system/sh.nix
    ./apps/vscode/default.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
   
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  home.packages = with pkgs; [
    wezterm
    neovim
  ];

  home.file = {
  };

  programs = {
    home-manager = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "fredrikscode";
      userEmail = "fredrik@kihlstedt.io";
      extraConfig = {
        init.defaultBranch = "main";
        core.editor = "nvim";
        # To avoid git freaking out over dubious permissions
        safe.directory = "/home/${userSettings.username}/.dotfiles";
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";

}
