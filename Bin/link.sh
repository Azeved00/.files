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
        mv $FILE $BACKUP
    else
        rm -rf $FILE
    fi

    ln -s $2 $FILE
}


if ! [ -d $BACKUP ]; then
	mkdir $BACKUP
fi

# RC File
linkFile "$HOME/.bashrc"      "$DotFilesFolder/RC/bash"
linkFile "$HOME/.inputrc"     "$DotFilesFolder/RC/input"
linkFile "$HOME/.gitconfig"   "$DotFilesFolder/RC/gitconfig"
linkFile "$HOME/.ssh/config"  "$DotFilesFolder/RC/ssh"

linkFile "$HOME/.config/nvim" "$DotFilesFolder/Config/nvim"
linkFile "$HOME/.config/polybar" "$DotFilesFolder/Config/polybar"
linkFile "$HOME/.config/alacritty" "$DotFilesFolder/Config/alacritty"
linkFile "$HOME/.config/rofi" "$DotFilesFolder/Config/rofi"
linkFile "$HOME/.config/picom" "$DotFilesFolder/Config/picom"
linkFile "$HOME/.config/i3" "$DotFilesFolder/Config/i3"


