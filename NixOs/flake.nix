{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

    outputs = { self, nixpkgs, ... }: 
    let
        username = "azevedo";
        system = "x86_64-linux";
	    pkgs = nixpkgs.legacyPackages.${system};
    in
    {
        nixosConfigurations = {
            home-pc = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit system username; };
                
                system = system;

                modules = [
		    ./configuration.nix
                    ./hardware-configs/home-pc.nix
                ];
            };

	    vm = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit system username; };
                
                system = system;

                modules = [
                    ./hardware-configs/vm.nix
                    ./configuration.nix
                ];
            };
        };
    };
}
