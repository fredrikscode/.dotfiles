{ config, ... }:

{

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    # Sway-specific Configuration
    config = rec {
      modifier = "Mod4";
      terminal = "wezterm";
      menu = "wofi --show run";
      # Status bar(s)
      bars = [{
        fonts.size = 15.0;
        # command = "waybar"; You can change it if you want
        position = "bottom";
      }];
      output = {
        "Virtual-1" = {
          mode = "3840x1600@60Hz";
        };
      };
    };
  };

}