{ config, libs, inputs, pkgs, username, gitUsername, gitEmail, ... }:

{

  imports = [
  ];
   
  home.username = username;
  home.homeDirectory = "/home/"+username;
  home.stateVersion = "23.11";

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
    ];
    settings = {
      "plugin:borders-plus-plus" = {
        add_borders = 1;
        col.border_1 = "rgb(ffffff)";
        col.border_2 = "rgb(2222ff)";
        border_size_1 = 10;
        border_size_2 = -1;
        natural_rounding = "yes";
      };
    };
  };

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
