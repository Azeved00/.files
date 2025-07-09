{ stdenv
, fetchzip
, lib
, makeWrapper
, appimageTools
, ...
}:

stdenv.mkDerivation rec {
  pname = "curseforge";
  version = "latest";

  src = fetchzip {
    url = "https://curseforge.overwolf.com/downloads/curseforge-latest-linux.zip";
    hash = "sha256-REPLACE_ME_WITH_ACTUAL_HASH";  # You'll need to fill this in
    stripRoot = false;
  };

  nativeBuildInputs = [ makeWrapper appimageTools ];

  installPhase = ''
    mkdir -p $out/bin

    # Move AppImage to output and make executable
    cp CurseForge.AppImage $out/bin/curseforge
    chmod +x $out/bin/curseforge

    # Optionally wrap it with appimage-run for environment sanity
    makeWrapper ${appimageTools.appimage-run}/bin/appimage-run $out/bin/curseforge-wrapper \
      --add-flags "$out/bin/curseforge"
  '';

  meta = with lib; {
    description = "CurseForge Linux client (AppImage)";
    homepage = "https://curseforge.overwolf.com/";
    license = licenses.unfree;
    maintainers = with maintainers; [ Enzime ];
    platforms = [ "x86_64-linux" ];
  };
}
