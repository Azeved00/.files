echo ""
echo "----------------------- linking config files ----------------------- "
BACKUP=$DotFilesFolder/Backup 

#creating symlinks to where the config files should be
#while moving the alredy existing ones to the Backup folder
linkFile () {
    local FILE=$1
    local DIR=$(dirname $FILE)

    echo "linking $FILE"

    mkdir -p $DIR
    if [[ -h $FILE || -f $FILE || -d $FILE ]]; then
        sudo mv $FILE $BACKUP
    else
        sudo rm -rf $FILE
    fi

    sudo ln -s $2 $FILE
}


if ! [ -d $BACKUP ]; then
	mkdir $BACKUP
fi


linkFile "/etc/nixos/configuration.nix"     "$DotFilesFolder/NixOs/configuration.nix"
linkFile "/etc/nixos/nix.conf"              "$DotFilesFolder/NixOs/nix.conf"
linkFile "/etc/nixos/modules"               "$DotFilesFolder/NixOs/modules"

