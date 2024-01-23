{...}:
let
    EN = "en_EN.UTF-8";
    US = "en_US.UTF-8";
    PT = "pt_PT.UTF-8";
in
{
    # Set your time zone.
    time.timeZone = "Europe/London";

    # Select internationalisation properties.
    i18n = {
        supportedLocales = [ "${EN}/UTF-8" "${PT}/UTF-8" "${US}/UTF-8"];
        defaultLocale = EN ;
        extraLocaleSettings = {
            LANG = EN;
            LC_MESSAGES = US;
            LC_NUMERIC = PT;
            LC_TIME = EN;
            LC_MONETARY = PT;
            LC_PAPER = PT;
            LC_NAME = PT;
            LC_ADRESS = PT;
            LC_TELEPHONE = PT;
            LC_CTYPE = US;
        };
    };

    console = {
        font = "jetbrains-mono";
        # keyMap = "pt";
        useXkbConfig = true; 
    };
}
