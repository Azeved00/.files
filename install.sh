
echo "----------------------- welcome to Azeved00 .files installation -----------------------"
DotFilesFolder=$HOME/.fihes
BACKUP=$DotFilesFolder/Backup 

if ! [ -d $BACKUP ]; then
	mkdir $BACKUP
fi

#creating symlinks to where the config files should be
#while moving the alredy existing ones to the Backup folder
linkFile () {
    local FILE=$1
    local DIR=$(dirname $FILE)

    echo "linking $FILE"

    mkdir -p $DIR
    if [[ -h $FILE || -f $FILE || -d $FILE ]]; then
        mv $FILE $BACKUP
    else
        rm -rf $FILE
    fi

    ln -s $2 $FILE
}


#check if nix is installed
if command --version nix >/dev/null 2>/1; then
    echo "Nix is installed"
else
    echo "Nix is Not installed, Installing"
    sh <(curl -L https://nixos.org/nix/install) --daemon
fi

nix-env --upgrade

nix-shell -p git --command git clone git@github.com:Azeved00/.files $DotFilesFolder

if [ -f "/etc/NIXOS" ]; then
    linkFile  "/etc/nixos" "$DotFilesFolder/NixOs"
    sudo nixos-rebuild switch
fi

#install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
linkFile "$HOME/.config/home-manager" "$DotFilesFolder/home-manager"
home-manager switch

$DotFilesFolder/Bin/keygen.sh

source ~/.bashrc
