{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        teeny-sddm.url ="github:Azeved00/teeny-sddm";
        bright-bit.url ="github:Azeved00/bright-bit";
        #bright-bit.url ="path:/home/azevedo/Dev/bright-bit";
	};

    outputs = { self, nixpkgs, ... } @ inputs: 
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        theme = inputs.bright-bit.nixosModules.colors;

        extraArgs = {inherit inputs theme;};
    in
    {
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
                    ./home-manager/base.nix 
                    ./home-manager/guis.nix 
                ];
    	    };

            wsl = inputs.home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = extraArgs;
                modules = [ 
                    ./home-manager/base.nix 
                ];
            };
        };
    };
}
