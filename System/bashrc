#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#shapes and colors
alias ls='ls --colo=auto'
PS1="\e[1;33m\t \W 
>\e[0;37m"

#navigation
alias ..='cd ../'
alias .='ls ./'
alias ...='cd ../../'
alias mysql='mysql -u root -p'

#nvim shannannigans
nvim_cd()
{
    if [ -d "${1}" ]; then
        local dir="${1}"
        shift 1
        ( cd "${dir}" && nvim "${@}" )
    else
        \nvim "${@}"
    fi
}
alias nvim=nvim_cd
alias vim=nvim

# git for my dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/Development/Dotfiles/ --work-tree=$HOME'

#paths and trails
export PATH=$HOME/.local/bin:$PATH
ZDOTDIR="$HOME/.config/zsh"
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#npm config set cache ~/.config/npm --global

