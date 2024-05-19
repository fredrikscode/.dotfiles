{ config, libs, pkgs, userSettings, ... }:

{

  imports = [
    #./user/sway/default.nix
    ./system/sh.nix
    ./apps/vscode/default.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;

    settings = {
      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
      };

      "$mod" = "SUPER";

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
    };
    
  };
   
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  home.packages = with pkgs; [
    # Sway dependencies
    # wl-clipboard
    # mako
    # wofi
    # waybar
    # ---
    wezterm
    neovim
  ];

  home.file = {
  };

  programs.git = {
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fredrik/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";

}
