#!/bin/bash 
echo ""
echo "----------------------- linking config files ----------------------- "
BACKUP=$DotFilesFolder/Backup 

#creating symlinks to where the config files should be
#while moving the alredy existing ones to the Backup folder
moveFile () {
    local FILE=$1

    echo "linking $FILE"

    if [[ -h $FILE || -f $FILE ]]; then
        mv $FILE $BACKUP
    fi

    ln -s $2 $FILE
}

# check if the folder exists
# if it exists move it to the back up
# and soft link each of
# this needs to be redone
moveFolder () {
    mkdir -p $1

    echo "linking directory $1"
    if [ -d $1 ]; then 
        mv -f $1 $BACKUP
    fi

    #link each file in the folder
    for FILE in $2/$3/* ; do
	    if [ -f $FILE ]; then
            ln -s $FILE $1
        fi
    done
}

if ! [ -d $BACKUP ]; then
	mkdir $BACKUP
fi

# RC File
moveFile "$HOME/.bashrc"      "$DotFilesFolder/RC/bash"
moveFile "$HOME/.inputrc"     "$DotFilesFolder/RC/input"
moveFile "$HOME/.gitconfig"   "$DotFilesFolder/RC/gitconfig"
moveFile "$HOME/.ssh/config"  "$DotFilesFolder/RC/ssh"

moveFile "$HOME/.config/nvim/init.vim" "$DotFilesFolder/Config/nvim/init.vim"


