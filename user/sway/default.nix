{ config, ... }:

{

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    # Sway-specific Configuration
    config = {
      terminal = "wezterm";
      menu = "wofi --show run";
      # Status bar(s)
      bars = [{
        fonts.size = 15.0;
        # command = "waybar"; You can change it if you want
        position = "bottom";
      }];
      # Display device configuration
      output = {
        eDP-1 = {
          # Set HIDP scale (pixel integer scaling)
          scale = "1";
        };
      };
    };
  };

}