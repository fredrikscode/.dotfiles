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
      theme = "sleek-grub-theme";
    };
  };
}