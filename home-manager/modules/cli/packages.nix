{ config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.terminal.packages;
    devapp = pkgs.writeShellApplication {
        name = "dev";
        text = ''
            # Default values for options
            DIRECTORY="$PWD"
            SESSION_NAME=""
            NIX_RENAME=true
            NIX_SHELL=true
            MONO=true

            # Function to display help
            usage() {
                echo "Usage: $0 [directory] [-r] [-k] [-s] [-h]"
                echo "  DIRECTORY       Directory to change to (default is current directory)"
                echo "  -r              Do not read the name from the nix shell"
                echo "  -k              Do not start a nix shell"
                echo "  -s              initial window will be split into 2 panes"
                echo "  -h              Help/Usage"
                exit 1
            }

            if [[ -d "$1" ]]; then
                DIRECTORY="$1"
                shift
            fi

            # Parse options
            while getopts ":skhr" opt; do
                case $opt in
                    r) NIX_RENAME=false;;
                    k) NIX_SHELL=false ;;
                    s) MONO=false;;
                    h) usage ;;
                    *) usage ;;
                esac
            done

            pushd "$DIRECTORY"

            # Determine session name
            if [[ -z "$SESSION_NAME" ]]; then
                SESSION_NAME=$(basename "$PWD")
            fi

            tmux new-session -d -s "$SESSION_NAME"

            # Handle nix develop step if flake.nix exists and SKIP_NIX_DEVELOP is false
            if [ "$NIX_SHELL" = true ]; then
                if [ -f "flake.nix" ] && [ "$NIX_RENAME" = true ]; then
                    tmux send-keys -t "$SESSION_NAME":0.0 "tmux rename-session \"\$(nix --quiet develop --quiet -c bash -c \"env | awk -F'=' '{ if (\\\$1 == \\\"name\\\") print \\\$2 }'\")\"; clear" Enter
                fi

                if [ "$MONO" = false ]; then
                    tmux split-window -h -t "$SESSION_NAME":0 "nix develop --impure"
                fi

                tmux send-keys -t "$SESSION_NAME":0.0 "nix develop --impure" Enter
            fi
            tmux attach-session -t "$SESSION_NAME"

            popd
        '';
    };
in
{
    options.dotfiles.home-manager.terminal.packages = {
        enable = lib.mkEnableOption "Enable terminal extra packages";
    };


    config = lib.mkIf cfg.enable  {

        home.packages = with pkgs; [ 
            tree
            btop
            zip
            unzip
            killall
            devapp
        ];

    };
}
