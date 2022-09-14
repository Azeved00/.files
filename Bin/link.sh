#!/bin/bash
echo "linking config files"
#creating symlinks to where the config files should be
#while moving the alredy existing ones to the Backup folder

if ! [ -d $DotFilesFolder/Backup ]; then
	mkdir $DotFilesFolder/Backup
fi

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

#gitconfig
if [ -f ~/.gitconfig ]; then	
	mv ~/.gitconfig $DotFilesFolder/Backup/
fi
ln -s $DotFilesFolder/RC/gitconfig ~/.gitconfig



#nvim
pathVim=~/.config/nvim/init.vim
if ! [ -d ~/.config/nvim ]; then
	mkdir -p ~/.config/nvim
fi

if  [ -f $pathVim ]; then
	mv $pathVim $DotFilesFolder/Backup/nvimConfig.vim
fi

ln -s $DotFilesFolder/Config/nvim/init.vim $pathVim
unset pathVim


