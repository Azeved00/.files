{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
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
        };

    	homeConfigurations = {
            blizzard = mkHome system ./home-manager/profiles/blizzard.nix;
            frost = mkHome system ./home-manager/profiles/frost.nix;
        };
    };
}
