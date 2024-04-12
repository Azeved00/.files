{
    description = "custom eww module";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

    outputs = { self, ... } @ inputs: 
    let
        pkgs = import inputs.nixpkgs { inherit system; };
        ROOT = "$HOME/Dev/dotfiles/home-manager/modules/eww-bar/";
        name = "eww development";
        system = "x86_64-linux";
    in {
        devShells."${system}".default = pkgs.mkShell {
            inherit name ROOT;

            buildInputs = with pkgs; [ eww ];

            shellHook = ''
                export NIX_SHELL_NAME="${name}" 
                echo -ne "\033]0;${name}\007"


                alias eww="${pkgs.eww}/bin/eww"
                eww daemon --config ${ROOT}

                alias open="eww open bar --config ${ROOT}"
                alias close="eww close-all --config ${ROOT}"

                reload
                trap "${pkgs.eww}/bin/eww kill --config ${ROOT}" EXIT
            '';

        };
    };
}
