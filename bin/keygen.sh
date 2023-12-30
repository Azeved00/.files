echo ""
echo "------------------- generating key ------------------"

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" 
fi

read -p "Enter your email address: " email
read -p "Enter the desired SSH key file name (without extension): " key_filename

ssh_key_file="$HOME/.ssh/${key_filename}"


if [ -f "$ssh_key_file" ]; then
    echo "SSH key file '$key_filename' already exists!"
    read -p "Do you want to proceed and overwrite? (y/n): " overwrite_response
    if [ "$overwrite_response" != "y" ]; then
        echo "Aborting."
        exit 1
    fi
fi

ssh-keygen -t ed25519 -C "$email" -f "$ssh_key_file"

ssh-add "$ssh_key_file"
cat "${ssh_key_file}.pub"
