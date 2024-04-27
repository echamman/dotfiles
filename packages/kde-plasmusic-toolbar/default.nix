{ pkgs, lib, stdenv, ... }:

let
  pluginName = "plasmusic-toolbar";
in
stdenv.mkDerivation {
  pname = "kde-${pluginName}";
  version = "1.1.0";
  src = pkgs.fetchzip {
    stripRoot = false;
    url = "https://github.com/ccatterina/plasmusic-toolbar/releases/download/v1.1.0/plasmusic-toolbar-v1.1.0.plasmoid";
    sha256 = "sha256-8+07A3AmPStrJwPEeGDvsV3YX3YgX0P7AXaRJv9QJek=";
    extension = "zip";
  };

  installPhase = ''
    runHook preInstall

    sharePath="$out/share/plasma/plasmoids/${pluginName}"
    mkdir -p $sharePath
    mv * $sharePath

    runHook postInstall
  '';

  meta = with lib; {
    description = "A widget for KDE Plasma 6 that shows currently playing song information and provide playback controls.";
    homepage = "https://github.com/ccatterina/plasmusic-toolbar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
