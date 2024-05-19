{
  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
    url = "github:hyprwm/hyprland-plugins";
    inputs.hyprland.follows = "hyprland";
  };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }:

    let
      systemSettings = {
        system = "x86_64-linux";
        hostname = "nixed";
        timezone = "Europe/Stockholm";
      };

      userSettings = {
        username = "fredrik";
      };

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${"x86_64-linux"};
    in {
      nixosConfigurations = {
        nixed = lib.nixosSystem {
          inherit (systemSettings) system;
          specialArgs = {
            inherit systemSettings userSettings pkgs;
            inputs = self.inputs;  # Pass inputs from self
          };
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations = {
        fredrik = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit userSettings;
            inputs = self.inputs;  # Pass inputs from self
          };
          modules = [ ./home.nix ];
        };
      };
    };
}
