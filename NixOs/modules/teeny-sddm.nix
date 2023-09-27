{qtbase
, qtsvg
, qtgraphicaleffects
, qtquickcontrols2
, wrapQtAppsHook
, stdenvNoCC
, fetchFromGitHub
}:
stdenvNoCC.mkDerivation {
    pname = "teeny-sddm";
    version = "1.0";
    dontBuild = true;
    
    src = fetchFromGitHub {
        owner = "Azeved00";
        repo = "teeny-sddm";
        rev = "445aa46a5c88b190b511e6ff3a0581bf74a214cb";
        hash = "sha256-oeM7ihr+aGDM3ZdjDel4b6PU7jfQTxYx3yJT5fBISoc=";
    };

    nativeBuildInputs = [
        wrapQtAppsHook
    ];

    propagatedUserEnvPkgs = [
        qtbase
        qtsvg
        qtgraphicaleffects
        qtquickcontrols2
    ];


    installPhase = ''
        mkdir -p $out/share/sddm/themes
        cp -aR $src/theme $out/share/sddm/themes/teeny-sddm
    '';
}
