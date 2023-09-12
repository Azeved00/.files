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
        rev = "10c44840f5efe403d50989c64eba105159a34ae1";
        hash = "sha256-BZerxC5gl+fSEYfeWs6HqiImjiegpexHXRwMs/Bl21s=";
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
