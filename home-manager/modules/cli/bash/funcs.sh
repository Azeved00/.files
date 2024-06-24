function link-proj() {
    ln -s "$PWD/$1" "$HOME/Dev/$2"
}

function dev() {
    if [[ -n "$1" ]] ; then
        pushd "$1" 
    else
        pushd "$PWD" 
    fi

    local TEMP=$(basename "$PWD")
    tmux new-session -d -s "$TEMP";
    if [ -f "flake.nix" ]; then
        tmux split-window -h -t "$TEMP":0 "nix develop --impure";
        tmux send-keys -t "$TEMP":0.0 "tmux rename-session \"\$(nix --quiet develop --quiet -c bash -c \"env | awk -F'=' '{ if (\\\$1 == \\\"name\\\") print \\\$2 }'\")\"" Enter
    fi
    tmux attach-session;

    popd
}
