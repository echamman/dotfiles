{ pkgs, lib, stdenv, ... }:

let
  pluginName = "plasmusic-toolbar";
in
stdenv.mkDerivation {
  pname = "kde-${pluginName}";
  version = "2.3.0";
  src = pkgs.fetchzip {
    stripRoot = false;
    url = "https://github.com/ccatterina/plasmusic-toolbar/releases/download/v2.3.0/plasmusic-toolbar-v2.3.0.plasmoid";
    sha256 = "sha256-a4+Tvu74qmbNxycj0d550RVljXrjgs5ibwoIlwhAqbs=";
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
