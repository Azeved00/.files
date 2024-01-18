{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        #bright-bit.url ="github:Azeved00/bright-bit";
        bright-bit.url ="path:/home/azevedo/Dev/bright-bit";
	};

    outputs = { self, nixpkgs, ... } @ inputs: 
    let
        myLib = import ./lib/default.nix {inherit inputs;};
        system = "x86_64-linux";
        extraArgs = {inherit inputs;};
    in
    with myLib; {
        nixosModule = import ./nixos/modules;
        #nixosModules.profile = import ./nixos/profiles;
        homeManagerModule = import ./home-manager/modules;
        homeManagerModules.profile = import ./home-manager/profiles;


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
            azevedo = mkHome system ./home-manager/profiles/full.nix;
            wsl = mkHome system ./home-manager/profiles/wsl.nix;
        };
    };
}
