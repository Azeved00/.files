make_prompt(){
    RESET='\[\e[0m\]'

    YELLOW='\[\e[1;33m\]'
    BLACK='\[\e[1;30m\]'
    GREEN='\[\e[1;32m\]'
    BLUE='\e[1;34m\]'
    WHITE='\e[1;97m\]'

    BG_BLUE='\e[44m\]'
    BG_GREEN='\e[42m\]'

    PS1=""
    if [ -n "$IN_NIX_SHELL" ] ; then 
        if [ -n "$NIX_SHELL_NAME" ] ; then
            PS1+="$BG_BLUE$BLACK $NIX_SHELL_NAME"
        else
            PS1+="$BG_BLACK$BLUE Shell"
        fi
        
        PS1+="$RESET"

        if [ -n "$GB" ] ; then
            PS1+="$BG_GREEN$BLUE" 
        else
            PS1+="$BLUE"
        fi
    fi
    PS1+="$RESET"

    GB="$(git symbolic-ref --short HEAD 2>/dev/null)"
    if [ -n "$GB" ] ; then
        PS1+="$WHITE$BG_GREEN  $GB "
        PS1+="  "
        PS1+="$RESET$GREEN$RESET "
    fi
    PS1+="$RESET"

    PS1+="$YELLOW\t \W >"
    PS1+="$RESET"
}
