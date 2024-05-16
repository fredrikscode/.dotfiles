{ config, libs, pkgs, userSettings, ... }:

{
  
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    neovim

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;

    shellAliases = {
      ".." = "cd ..";
      c = "clear -x";
      ll = "ls -lah";
      reb = "sudo nixos-rebuild switch --flake .#nixed";
      hom = "home-manager switch --flake .#${userSettings.username}";
      s = "nix --extra-experimental-features nix-command flake search nixpkgs";
      v = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "wezm";
    };
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

  home.file = {
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

  home.stateVersion = "23.11"; # Please read the comment before changing.

}
