{ config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.terminal.packages;
    devapp = pkgs.writeShellApplication {
        name = "dev";
        text = ''
            # Default values for options
            DIRECTORY="$PWD"
            SESSION_NAME=""
            SKIP_NIX_RENAME=false
            MONO=true

            # Function to display help
            usage() {
                echo "Usage: $0 [directory] [-k] [-s] [-h]"
                echo "  DIRECTORY       Directory to change to (default is current directory)"
                echo "  -k              Do not read the name from the nix shell"
                echo "  -s              initial window will be split into 2 panes"
                echo "  -h              Help/Usage"
                exit 1
            }

            if [[ -d "$1" ]]; then
                DIRECTORY="$1"
                shift
            fi

            # Parse options
            while getopts ":skh" opt; do
                case $opt in
                    k) SKIP_NIX_RENAME=true ;;
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
            if [ -f "flake.nix" ] || [ "$SKIP_NIX_RENAME" = false ]; then
                tmux send-keys -t "$SESSION_NAME":0.0 "tmux rename-session \"\$(nix --quiet develop --quiet -c bash -c \"env | awk -F'=' '{ if (\\\$1 == \\\"name\\\") print \\\$2 }'\")\"; clear" Enter
            fi
            if [ "$MONO" = false ]; then
                tmux split-window -h -t "$SESSION_NAME":0 "nix develop --impure"
            fi

            tmux send-keys -t "$SESSION_NAME":0.0 "nix develop --impure" Enter

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
