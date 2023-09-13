
echo "----------------------- welcome to Azeved00 .files installation -----------------------"
DotFilesFolder="/home/azevedo/.files"

#creating symlinks to where the config files should be
#while moving the alredy existing ones to the Backup folder
linkFile () {
    local FILE=$1
    local DIR=$(dirname $FILE)
    
    BACKUP="$DotFilesFolder/Backup" 
    if ! [ -d $BACKUP ]; then
        mkdir $BACKUP
    fi

    echo "creating $2 link @ $FILE"

    mkdir -p $DIR
    if [[ -h $FILE || -f $FILE || -d $FILE ]]; then
        mv $FILE $BACKUP
    else
        rm -rf $FILE
    fi

    ln -s $2 $FILE
}


#check if nix is installed
if nix --version > /dev/null ; then
    echo "Nix is installed"
else
    echo "Nix is Not installed, Installing"
    sh <(curl -L https://nixos.org/nix/install) --daemon
    nix-env --upgrade
fi


nix-shell -p git --run "git clone -b home-manager -- https://github.com/Azeved00/.files.git $DotFilesFolder"


# if in NixOs link necessary files and rebuild switch
if [ -f "/etc/nixos/configuration.nix" ]; then
    linkFile "/etc/nixos/configuration.nix" "$DotFilesFolder/NixOs/configuration.nix"
    linkFile "/etc/nixos/modules" "$DotFilesFolder/NixOs/modules"

    nixos-rebuild switch
fi

#install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
linkFile "$HOME/.config/home-manager" "$DotFilesFolder/home-manager"
home-manager switch

$DotFilesFolder/Bin/keygen.sh

source ~/.bashrc
