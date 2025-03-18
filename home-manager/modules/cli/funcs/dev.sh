# Default values for options
DIRECTORY="$PWD"
SESSION_NAME=""
NIX_RENAME=true
NIX_SHELL=true
MONO=true
ATTACH=true

HISTORY_FILE="$XDG_CONFIG_HOME/last_dev"

# Function to display help
usage() {
    echo "Usage: $0 [directory] [-r] [-k] [-s] [-h] [-a]"
    echo "  DIRECTORY       Directory to change to (default is current directory)"
    echo "  -r              Do not read the name from the nix shell"
    echo "  -k              Do not start a nix shell"
    echo "  -s              initial window will be split into 2 panes"
    echo "  -a              Don't attach to tmux"
    echo "  -h              Help/Usage"
    exit 1
}

if [ $# -eq 0 ]; then
    # If no arguments are passed, execute the last stored command
    if [ -f "$HISTORY_FILE" ]; then
        LAST_COMMAND=$(cat "$HISTORY_FILE")
        echo "Running last command: $LAST_COMMAND"
        eval "$LAST_COMMAND"
    else
        echo "No previous command found."
    fi
    exit 1
fi

echo "dev $*" > "$HISTORY_FILE"

if [[ -d "$1" ]]; then
    DIRECTORY="$1"
    shift
fi

# Parse options
while getopts ":skhra" opt; do
    case $opt in
        r) NIX_RENAME=false;;
        k) NIX_SHELL=false ;;
        s) MONO=false;;
        a) ATTACH=false;;
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
        tmux send-keys -t "$SESSION_NAME":1.0 "tmux rename-session \"\$(nix --quiet develop --quiet -c bash -c \"env | awk -F'=' '{ if (\\\$1 == \\\"name\\\") print \\\$2 }'\")\"; clear" Enter
    fi

    if [ "$MONO" = false ]; then
        tmux split-window -h -t "$SESSION_NAME":1 "nix develop --impure"
    fi

    tmux send-keys -t "$SESSION_NAME":1.0 "nix develop --impure" Enter
fi

if  [ "$ATTACH" = false ] && [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; then
    echo "Already inside tmux, not attaching to new session"
else
    tmux attach-session -t "$SESSION_NAME"
fi

popd
