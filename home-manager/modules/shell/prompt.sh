make_prompt(){
    # colors
    local RESET='\[\e[0m\]'

    local YELLOW='\[\e[1;33m\]'
    local BLACK='\[\e[1;30m\]'
    local GREEN='\[\e[1;32m\]'
    local BLUE='\e[1;34m\]'
    local WHITE='\e[1;97m\]'

    local BG_BLUE='\e[44m\]'
    local BG_GREEN='\e[42m\]'
    local BG_BLACK='\e[40m\]'

    # other vars

    local GB="$(git symbolic-ref --short HEAD 2>/dev/null)"
    local SEPARATOR=""
    PS1=""

    # function to put separators correctly
    # parameters
    # 1 and 2 are left and right vars
    # 3 foreground and 4 balckground colors
    make_separator() {
        local last_char=${PS1: -1}
        if [[ "$last_char" == "$SEPARATOR" ]]; then
            PS1="${PS1:0:-1}$2$SEPARATOR"
            PS1+="$RESET$2 ";
        else
            PS1+="$RESET";
        fi
    }

    if [[ -n "$IN_NIX_SHELL" ]] ; then 
        if [[ -n "$NIX_SHELL_NAME" ]] ; then
            PS1+="$BG_BLUE$BLACK $NIX_SHELL_NAME"
        else
            PS1+="$BG_BLACK$BLUE Shell"
        fi
        PS1+="$RESET$BLUE$SEPARATOR"
    fi
    make_separator "$GB" "$BG_GREEN"

    if [[ -n "$GB" ]] ; then
        PS1+="$WHITE$BG_GREEN $GB  "
        PS1+=" +1 -1"
        PS1+="$RESET$GREEN$SEPARATOR"
    fi
    make_separator "a" "$BG_BLACK"

    PS1+="$YELLOW\t \W  "
    PS1+="$RESET"
}
