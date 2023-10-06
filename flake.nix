{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs }: 
    let
        mysystem = "x86_64-linux";

        pkgs = import nixpkgs {
            inherit mysystem;
            config = {
                allowUnfree = true;
            };
        };
    in
    {
        nixosConfigurations = {
            myNixos = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit mysystem; };
                
                system = mysystem;

                modules = [
                    ./NixOs/configuration.nix
                ];
            };
        };

    };
}
