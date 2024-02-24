{
    description = "your description";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

    outputs = { self, ... } @ inputs: 
    let
        pkgs = import inputs.nixpkgs { inherit system; };
        ROOT = builtins.getEnv "PWD";
        name = "name of your shell";
        system = "x86_64-linux";
    in {
        devShells."${system}".default = pkgs.mkShell {
            inherit name ROOT;

            buildInputs = with pkgs; [];

            shellHook = ''
                export NIX_SHELL_NAME="${name}" 
                echo -ne "\033]0;${name}\007"

                reload
            '';

        };
    };
}
