{...}:
{
    users.mutableUsers = true;

    users.users.azevedo = {
        description = "Azevedo";
        isNormalUser = true;
        initialPassowrd = "pw123";
        extraGroups = [  "networkmanager" "wheel" "audio" ];
    };
}
