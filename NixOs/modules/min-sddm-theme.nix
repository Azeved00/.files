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
    rev = "c584d06f97b29140957c8cd1e9f63eb6c8176627";
    hash = "sha256-DQ8OiJFwoFFQuqWIxLdJIuPVEiba6kbzCpamQU+WquA=";
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
