{ config, lib, inputs, pkgs, timezone, username, ... }:

{
  imports =
    [
      ./hardware.nix
      ../../system/boot.nix
      ../../system/gpu.nix
      ../../system/network.nix
    ];

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

  environment = {
    variables = {
      XDG_CONFIG_HOME = "${builtins.getEnv "HOME"}/.dotfiles";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  services = {
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