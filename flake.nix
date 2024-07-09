{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        hyprland = {
            type = "git";
            url = "https://github.com/hyprwm/Hyprland";
            submodules = true;
        };

        bright-bit.url ="github:Azeved00/bright-bit";
        #bright-bit.url ="path:/home/azevedo/Dev/bright-bit";
	};

    outputs = { self, nixpkgs, ... } @ inputs: 
    let
        myLib = import ./lib/default.nix {inherit inputs;};
        system = "x86_64-linux";
    in
    with myLib; {
        nixosModule = import ./nixos/modules;
        nixosModules.profile = import ./nixos/profiles;
        homeManagerModule = import ./home-manager/modules;
        homeManagerModules.profile = import ./home-manager/profiles;


        nixosConfigurations = {
            blizzard = mkSystem system ./nixos/profiles/blizzard;
            chilly = mkSystem system ./nixos/profiles/chilly;
	        glaceon = mkSystem system ./nixos/profiles/glaceon;		
        };

    	homeConfigurations = {
            blizzard = mkHome system ./home-manager/profiles/blizzard.nix;
            frost = mkHome system ./home-manager/profiles/frost.nix;
	        glaceon = mkHome system ./home-manager/profiles/glaceon.nix;
        };

        templates.dev = {
            path = ./dev-template;
            description = "A general template for development through a nix shell";
        };


        devShells."${system}".default = (mkPkgs system).mkShell {
            name = "Dotfiles Development";
        };
    };
}
