{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

    outputs = { self, nixpkgs, ... } @ inputs: 
    let
        inherit (self) outputs;

        system = "x86_64-linux";

	    pkgs = import nixpkgs {
            inherit system;

            config = {
                allowUnfree = true;
            };
        };
    in
    {
        nixosConfigurations = {
            home-pc = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit pkgs outputs inputs; };
                
                inherit system;

                modules = [
		            ./base.nix
                    ./hardware-configs/home-pc.nix

                    ./modules/users.nix
                    ./modules/network.nix
                    ./modules/fonts.nix
                    ./modules/xserver.nix
                    ./modules/packages.nix
                    ./modules/local.nix
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
