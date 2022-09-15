echo "welcome to Azeved00 .files installation"
echo "What is your OS?"
echo "Do you want GUI applications?"



echo "installing software"
sudo apt update -y
sudo apt upgrade -y

#installing applications
sudo apt install git -y
sudo apt install gcc -y
sudo apt install ghc -y
sudo apt install neovim -y
sudo apt install tree -y
sudo apt install man -y
sudo apt install curl -y

#installing apps
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	   
	   
export DotFilesFolder=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#and link config files to .config folder
$DotFilesFolder/Bin/link.sh

#run custom program to generate ssh keys for github
$DotFilesFolder/Bin/keygen.sh

source ~/.bashrc
