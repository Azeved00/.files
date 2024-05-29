function link-proj() {
    ln -s "$1" "$HOME/Dev/"
}

function dev() {
    pushd "$1" 

    #echo "$PWD"
    local NIX_SHELL_NAME="$(nix develop --impure -c bash -c "env | awk -F'=' '{ if (\$1 == \"name\") print \$2 }'")";
    tmux new-session -d -s "$NIX_SHELL_NAME";
    tmux split-window -h -t "$NIX_SHELL_NAME":0 "nix develop --impure";
    tmux attach -t "$NIX_SHELL_NAME";

    popd
}
