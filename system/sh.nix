{ config, pkgs, userSettings, ... }:

let
  myAliases = {
    ".." = "cd ..";
    c = "clear -x";
    ll = "ls -lah";
    rebuild = "sudo nixos-rebuild switch --flake .#nixed";
    manswitch = "home-manager switch --flake .#${userSettings.username}";
    "flake up" = "nix flake update /home/${userSettings.username}/.dotfiles";
    s = "nix search nixpkgs";
    v = "nvim";
  };
in

{

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyFileSize = 10000;
    shellAliases = myAliases;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    shellAliases = myAliases;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "wezm";
    };
  };

}