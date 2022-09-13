#!/bin/bash
echo "linking config files"
#creating symlinks to where the config files should be
#while moving the alredy existing ones to the Backup folder

#append path to core to bashrc
if [ -f ~/.bashrc ]; then
	mv ~/.bashrc $DotFilesFolder/Backup/
fi
ln -s $DotFilesFolder/RC/bash ~/.bashrc


if [ -f ~/.inputrc ]; then	
	mv ~/.inputrc $DotFilesFolder/Backup/
fi
ln -s $DotFilesFolder/RC/input ~/.inputrc
