{ config, libs, inputs, pkgs, username, gitUsername, gitEmail, ... }:

{

  imports = [
    ../../system/sh.nix
    ../../apps/vscode/default.nix
  ];
   
  home.username = username;
  home.homeDirectory = "/home/"+username;
  home.stateVersion = "23.11";

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
      userName = gitUsername;
      userEmail = gitEmail;
      extraConfig = {
        init.defaultBranch = "main";
        core.editor = "nvim";
        # To avoid git freaking out over dubious permissions
        safe.directory = "/home/${username}/.dotfiles";
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

}
