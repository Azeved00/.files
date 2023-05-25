echo "----------------------- welcome to Azeved00 .files installation -----------------------"
export DotFilesFolder=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

read -p "What is your OS?" OS
read -p "Do you want GUI applications?" APPS

if [ "$APPS" == "yes" ]; then
    echo "installing software"
    case "$OS" in
    "arch")
        $DotFilesFolder/Bin/packages.arc.sh
        ;;
    "windows")
        $DotFilesFolder/Bin/packages.win.sh
        ;;
    "debian")
        $DotFilesFolder/Bin/packages.deb.sh
        ;;
    "nixos")
        #link config to its place
        ;;
    *)
        echo "Invalid Option"
        return
        ;;
    esac

    #installing plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

fi
	   
	   

#link config files to .config folder
$DotFilesFolder/Bin/link.sh

#run custom program to generate ssh keys for github
$DotFilesFolder/Bin/keygen.sh

source ~/.bashrc
