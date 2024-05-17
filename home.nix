{ config, libs, pkgs, userSettings, ... }:

{

  imports = [
    ./system/sh.nix
  ];
   
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  home.packages = with pkgs; [
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
