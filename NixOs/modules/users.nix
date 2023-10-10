{...}:
{
    users.mutableUsers = true;

    users.users.azevedo = {
        description = "Azevedo";
        home = "/users/azevedo";
        isNormalUser = true;
        initialPassword = "pw123";
        extraGroups = [  "networkmanager" "wheel" "audio" ];
    };
}
