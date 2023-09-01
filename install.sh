
echo "----------------------- welcome to Azeved00 .files installation -----------------------"
DotFilesFolder=$HOME/.files

#creating symlinks to where the config files should be
#while moving the alredy existing ones to the Backup folder
linkFile () {
    local FILE=$1
    local DIR=$(dirname $FILE)
    BACKUP=$DotFilesFolder/Backup 

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
    sudo
else
    echo "Nix is Not installed, Installing"
    sh <(curl -L https://nixos.org/nix/install) --daemon
    nix-env --upgrade
fi


nix-shell -p git --run "git clone https://github.com:Azeved00/.files.git $DotFilesFolder"
if ! [ -d $DotFilesFolder/Backup ]; then
	mkdir $DotFilesFolder/Backup
fi

if [ -f "/etc/NIXOS" ]; then
    sudo nixos-rebuild switch -I nixos-config=$DotFilesFolder/NixOs/configuration.nix
fi

#install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
linkFile "$HOME/.config/home-manager" "$DotFilesFolder/home-manager"
home-manager switch

$DotFilesFolder/Bin/keygen.sh

source ~/.bashrc
