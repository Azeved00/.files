{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }: 
    let
        username = "azevedo";
        system = "x86_64-linux";
	    pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    	homeConfigurations.azevedo = home-manager.lib.homeManagerConfiguration {
	    	inherit pkgs;
	    	modules = [ ./home.nix ];
    	};
    };
}
