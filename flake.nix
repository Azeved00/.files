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
	};

    outputs = { self, nixpkgs, home-manager, teeny-sddm, bright-bit, ... } @ inputs: 
    let
        inherit (self) outputs;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        theme = bright-bit.nixosModules.colors;
    in
    {
        nixosConfigurations = {
            home-pc = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit outputs inputs teeny-sddm; };
                
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
                specialArgs = { };
                
                system = system;

                modules = [
                    ./NixOs/hardware-configs/vm.nix
                    ./NixOs/base.nix
                ];
            };
        };

    	homeConfigurations = {
            azevedo = home-manager.lib.homeManagerConfiguration {
	    	    inherit pkgs;
                extraSpecialArgs = { inherit theme bright-bit; };
	    	    modules = [ 
                    ./home-manager/base.nix 
                    ./home-manager/guis.nix 
                ];
    	    };

            wsl = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = { inherit theme bright-bit;};
                modules = [ 
                    ./home-manager/base.nix 
                    ./home-manager/wsl.nix 
                ];
            };
        };
    };
}
