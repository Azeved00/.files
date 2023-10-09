{...}:
{
    users.mutableUsers = true;

    users.users.azevedo = {
        description = "Azevedo";
        isNormalUser = true;
        initialPassword = "pw123";
        extraGroups = [  "networkmanager" "wheel" "audio" ];
    };
}
