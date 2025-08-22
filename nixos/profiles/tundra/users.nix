{...}:
{
    users.mutableUsers = true;

    users.users.root = {
        openssh.authorizedKeys.keyFiles = [
            ./glaceon.pub
            ./blizzard.pub
        ];
    };

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
            ./glaceon.pub
            ./blizzard.pub
        ];
    };
}
