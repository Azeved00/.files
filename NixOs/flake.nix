{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	home-manager = {
	    url = "github:nix-community/home-manager";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
    };

    outputs = { self, nixpkgs, home-manager, ... }: 
    let
        mysystem = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${mysystem};
    in
    {
        nixosConfigurations = {
            home-pc = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit mysystem; };
                
                system = mysystem;

                modules = [
                    ./hardware-configs/home-pc.nix
                    ./configuration.nix
                ];
            };
	    vm = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit mysystem; };
                
                system = mysystem;

                modules = [
                    ./hardware-configs/vm.nix
                    ./configuration.nix
                ];
            };

        };
	homeConfigurations.azevedo = home-manager.lib.homeManagerConfiguration {
		inherit pkgs;
		modules = [ ../home-manager/home.nix ];
	};
    };
}
