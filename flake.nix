{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        bright-bit.url ="github:Azeved00/bright-bit";
        #bright-bit.url ="path:/home/azevedo/bright-bit";
	};

    outputs = { self, nixpkgs, ... } @ inputs: 
    let
        myLib = import ./lib/default.nix {inherit inputs;};
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        theme = import ./Assets/colors.nix;

        extraArgs = {inherit inputs theme;};
    in
    with myLib; {
        nixosConfigurations = {
            home-pc = nixpkgs.lib.nixosSystem {
                specialArgs = extraArgs;
                
                inherit system;

                modules = [
		            ./NixOs/base.nix
                    ./NixOs/hardware-configs/home-pc.nix

                    ./NixOs/modules/users.nix
                    ./NixOs/modules/network.nix
                    ./NixOs/modules/fonts.nix
                    ./NixOs/modules/xserver.nix
                    ./NixOs/modules/packages.nix
                    ./NixOs/modules/locale.nix
                    ./NixOs/modules/services.nix
                    ./NixOs/modules/variables.nix
                ];
            };

	        vm = nixpkgs.lib.nixosSystem {
                specialArgs = extraArgs;
                
                system = system;

                modules = [
                    ./NixOs/hardware-configs/vm.nix
                    ./NixOs/base.nix

                    ./NixOs/modules/users.nix
                    ./NixOs/modules/network.nix
                    ./NixOs/modules/fonts.nix
                    ./NixOs/modules/xserver.nix
                    ./NixOs/modules/packages.nix
                    ./NixOs/modules/locale.nix
                    ./NixOs/modules/services.nix
                    ./NixOs/modules/variables.nix
                ];
            };
        };

    	homeConfigurations = {
            azevedo = inputs.home-manager.lib.homeManagerConfiguration {
	    	    inherit pkgs;
                extraSpecialArgs = extraArgs;
	    	    modules = [ 
                    inputs.bright-bit.homeManagerModule
                    ./home-manager/modules
                    ./home-manager/profiles
                    ./home-manager/profiles/full.nix
                ];
    	    };

            wsl = inputs.home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = extraArgs;
                modules = [ 
                    ./home-manager/base.nix 
                    ./home-manager/wsl.nix 
                ];
            };
        };
    };
}
