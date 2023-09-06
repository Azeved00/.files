{qtbase
, qtsvg
, qtgraphicaleffects
, qtquickcontrols2
, wrapQtAppsHook
, stdenvNoCC
, fetchFromGitHub
}:
stdenvNoCC.mkDerivation {
    pname = "min-sddm";
    version = "1.0";
    dontBuild = true;
    
    src = fetchFromGitHub {
    owner = "Azeved00";
    repo = "min-sddm";
    rev = "d38ae1a5c13b6f07ff7fc861ad895b5b19aa7a49";
    hash = "sha256-aDi9mytqq4F47LZ/sCT17SIGy3tEgUSAqvTyMQitJww=";
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
        cp -aR $src/theme $out/share/sddm/themes/min-sddm
    '';
}
