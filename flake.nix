{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

       sops-nix = {
            url = "github:mic92/sops-nix";
            inputs.nixpkgs.follows = "nixpkgs";
       };
        
        hyprland = {
            type = "git";
            url = "https://github.com/hyprwm/Hyprland";
            submodules = true;
        };
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        curseforge = {
            url = "github:Eveeifyeve/Curseforge-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        bright-bit.url ="github:Azeved00/bright-bit";
        dev-command.url ="github:Azeved00/dev-command";
        #bright-bit.url ="path:/home/azevedo/Dev/bright-bit";
        #dev-command.url ="path:/home/azevedo/Dev/dev-command";
	};

    outputs = { self, nixpkgs, ... } @ inputs: 
    let
        myLib = import ./lib/default.nix {inherit inputs;};
        system = "x86_64-linux";
    in
    with myLib; {
        nixosModule = import ./nixos/modules;
        homeManagerModule = import ./home-manager/modules;


        nixosConfigurations = {
            blizzard = mkSystem system ./nixos/profiles/blizzard {};
            #chilly = mkSystem system ./nixos/profiles/chilly {};
	        glaceon = mkSystem system ./nixos/profiles/glaceon {};		
	        tundra = mkSystem system ./nixos/profiles/tundra {};
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
