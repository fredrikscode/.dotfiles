{ config, lib, inputs, pkgs, timezone, username, host, ... }:
let
  myAliases = {
    ".." = "cd ..";
    c = "clear -x";
    ll = "ls -lah";
    rebuild = "sudo nixos-rebuild switch --flake .#${host}";
    manswitch = "home-manager switch --flake .#${username}";
    fup = "nix flake update /home/${username}/.dotfiles";
    s = "nix search nixpkgs";
    v = "nvim";
  };
in
{
  imports =
    [
      ./hardware.nix
    ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      # Garbage collection
      auto-optimise-store = true;
    };
    # Garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  xdg = {
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  networking.hostName = host;
  networking.networkmanager.enable = true;

  environment = {
    variables = {
      XDG_CONFIG_HOME = "${builtins.getEnv "HOME"}/.dotfiles";
    };
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };
    openssh = {
      enable = true;
    };
  };

  programs = {
    hyprland = {
      enable = true;
    };
    # Enable laptop brightness keys
    light = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      histSize = 10000;
      shellAliases = myAliases;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "wezm";
      };
    };
    bash = {
      enableCompletion = true;
      shellAliases = myAliases;
    };
  };

  time.timeZone = "Europe/Stockholm";
  
  users.users.${username} = {
    description = "Fredrik";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "video" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  system.stateVersion = "23.11"; # Did you read the comment?

}