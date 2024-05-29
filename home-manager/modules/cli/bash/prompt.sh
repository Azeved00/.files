make_prompt(){
    # colors
    local RESET='\[\e[0m\]'

    local YELLOW='\[\e[1;33m\]'
    local BLACK='\[\e[1;30m\]'
    local GREEN='\[\e[1;32m\]'
    local RED='\[\e[1;31m\]'
    local BLUE='\[\e[1;34m\]'
    local WHITE='\[\e[1;97m\]'

    local BG_BLUE='\[\e[44m\]\]'
    local BG_GREEN='\[\e[42m\]\]'
    local BG_RED='\[\e[41m\]\]'
    local BG_BLACK='\[\e[40m\]\]'
    local BG_YELLOW='\[\e[43m\]\]'

    # other vars

    local GB="$(git symbolic-ref --short HEAD 2>/dev/null)"
    local SEPARATOR=""
    PS1=""

    local LOCAL_COMMITS="$(git rev-list --count $GB --not origin/$GB 2>/dev/null)"
    local REMOTE_COMMITS="$(git rev-list --count origin/$GB --not $GB 2>/dev/null)"
    local NIX_SHELL_NAME="$(env | awk -F'=' '{ if ($1 == "name") print $2 }')";

    # function to put separators correctly
    # parameters
    # $1 the color of the next module
    make_separator() {
        local last_char=${PS1: -1}
        if [[ "$last_char" == "$SEPARATOR" ]]; then
            PS1="${PS1:0:-1}$1$SEPARATOR"
            PS1+="$RESET$1 ";
        else
            PS1+="$RESET";
        fi
    }

    PS1+="$BG_YELLOW$BLACK\t"
    PS1+="$RESET$YELLOW$SEPARATOR"

    if [[ -n "$IN_NIX_SHELL" ]] ; then 
        make_separator "$BG_BLUE"
        if [[ -n "$NIX_SHELL_NAME" ]] ; then
            PS1+="$BG_BLUE$BLACK $NIX_SHELL_NAME"
        else
            PS1+="$BG_BLUE$BLACK Shell"
        fi
        PS1+="$RESET$BLUE$SEPARATOR"
    fi

    if [[ -n "$GB" ]] ; then
        make_separator "$BG_RED"

        PS1+="$WHITE$BG_RED $GB  "
        PS1+=" +$LOCAL_COMMITS -$REMOTE_COMMITS"
        PS1+="$RESET$RED$SEPARATOR"
    fi

    make_separator "$BG_BLACK"
    PS1+="\n$BLUE\W $RESET "
    PS1+="$RESET"
}
