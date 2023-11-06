{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

    outputs = { self, nixpkgs, ... } @ inputs: 
    let
        inherit (self) outputs;

        system = "x86_64-linux";

    in
    {
        nixosConfigurations = {
            home-pc = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit outputs inputs; };
                
                inherit system;

                modules = [
		            ./base.nix
                    ./hardware-configs/home-pc.nix

                    ./modules/users.nix
                    ./modules/network.nix
                    ./modules/fonts.nix
                    ./modules/xserver.nix
                    ./modules/packages.nix
                    ./modules/locale.nix
                    ./modules/services.nix
                    ./modules/variables.nix
                ];
            };

	        vm = nixpkgs.lib.nixosSystem {
                specialArgs = { };
                
                system = system;

                modules = [
                    ./hardware-configs/vm.nix
                    ./base.nix
                ];
            };
        };
    };
}
