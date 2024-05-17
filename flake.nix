{

  inputs = {
  
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
  };

  outputs = { self, nixpkgs, home-manager, ... }:

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
            inherit systemSettings userSettings;
          };
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations = {
        fredrik = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit userSettings;
          };
	        modules = [ ./home.nix ];
	      };
      };
    };

}
