{...}:
{
    users.mutableUsers = true;

    users.users.azevedo = {
        description = "Azevedo";
        home = "/home/azevedo";
        isNormalUser = true;
        initialPassword = "pw123";
        extraGroups = [  
            "networkmanager" "wheel" "audio" 
            "dialout" "cdrom" "gamemode"
        ];

        openssh.authorizedKeys.keyFiles = [
            ./laptop.pub
        ];
    };
}
