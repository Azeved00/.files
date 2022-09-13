echo "installing software"
sudo apt update -y

#installing applications
sudo apt upgrade -y
sudo apt install git -y
sudo apt install gcc -y
sudo apt install ghc -y
sudo apt install neovim -y
sudo apt install tree -y
sudo apt install man -y

export DotFilesFolder=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#run custom program to generate ssh keys for github
$DotFilesFolder/Bin/keygen.sh

#and link config files to .config folder
$DotFilesFolder/Bin/link.sh

source ~/.bashrc
