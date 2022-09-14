#!/bin/bash
echo "linking config files"
#creating symlinks to where the config files should be
#while moving the alredy existing ones to the Backup folder

#bashrc 
if [ -f ~/.bashrc ]; then
	mv ~/.bashrc $DotFilesFolder/Backup/
fi
ln -s $DotFilesFolder/RC/bash ~/.bashrc

#inputrc
if [ -f ~/.inputrc ]; then	
	mv ~/.inputrc $DotFilesFolder/Backup/
fi
ln -s $DotFilesFolder/RC/input ~/.inputrc

#nvim
if ! [ -d ~/.config/nvim/ ]; then
	mkdir -p ~/.config/nvim
fi

if  [ -f ~/.config/nvim/init.vim ]; then
	mv ~/.config/nvim/init.vim $DotFilesFolder/Backup/nvimConfig.vim	
fi
ln -s $DotFilesFodler/Config/nvim/init.vim ~/.config/nvim/init.vim
