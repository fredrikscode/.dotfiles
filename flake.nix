{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = 
    inputs@{ nixpkgs, home-manager, ... }:
    let
      systemSettings = {
        system = "x86_64-linux";
        hostname = "nixed";
        timezone = "Europe/Stockholm";
      };

      userSettings = {
        username = "fredrik";
        gitUsername = "Fredrik Kihlstedt";
        gitEmail = "fredrik@kihlstedt.io";
      };

      pkgs = import nixpkgs {
        inherit systemSettings.system;
        config = {
          allowUnfree = true;
        };
      };
    in 
    {
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit systemSettings.system;
            inherit inputs;
            inherit userSettings.username;
            inherit host;
          };
          modules = [ 
            ./hosts/${host}/config.nix 
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit userSettings.username;
                inherit inputs;
                inherit host;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${userSettings.username} = import ./hosts/${host}/home.nix;
            }
          ];
        };
      };
    };
}