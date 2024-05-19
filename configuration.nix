{ config, lib, inputs, pkgs, systemSettings, userSettings, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./system/boot.nix
      ./system/gpu.nix
      ./system/network.nix
    ];

  nix = {
    settings = {
      # Enable flakes
      experimental-features = [ "nix-command" "flakes" ];
      # Garbage collection
      auto-optimise-store = true;
      # Cachix
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    # Garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
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
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
    openssh = {
      enable = true;
    };
  };

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };
    # Enable laptop brightness keys
    light = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
  };

  time.timeZone = systemSettings.timezone;
  
  users.users.${userSettings.username} = {
    description = "Fredrik";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "video" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  system.stateVersion = "23.11"; # Did you read the comment?

}