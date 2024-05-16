{ config, ... }:

{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      theme = "nixos-grub2-theme";
    };
  };
}