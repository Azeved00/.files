{
    description = "Configuration files shannanigans";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs }: 
    let
        mysystem = "x86_64-linux";
    in
    {
        nixosConfigurations = {
            home-pc = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit mysystem; };
                
                system = mysystem;

                modules = [
                    ./hardware-configs/home-pc.nix
                    ./configuration.nix
                ];
            };
        };

    };
}
