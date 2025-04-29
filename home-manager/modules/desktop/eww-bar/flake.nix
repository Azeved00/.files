{
    description = "custom eww module";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

    outputs = { self, ... } @ inputs: 
    let
        pkgs = import inputs.nixpkgs { inherit system; };
        ROOT = ./.;
        system = "x86_64-linux";
        workspaceapp = import ./scripts/workspace/package.nix (pkgs);
    in {
        devShells."${system}".default = pkgs.mkShell {
            inherit ROOT;

            buildInputs = with pkgs; [ eww workspaceapp];

            shellHook = ''
                alias eww="${pkgs.eww}/bin/eww"
                eww daemon --config ${ROOT}

                alias open="eww open bar --config ${ROOT}"
                alias close="eww close-all --config ${ROOT}"

                trap "${pkgs.eww}/bin/eww kill --config ${ROOT}" EXIT
            '';

        };
    };
}
