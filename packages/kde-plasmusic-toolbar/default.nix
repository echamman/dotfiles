{ pkgs, lib, stdenv, ... }:

let
  pluginName = "plasmusic-toolbar";
in
stdenv.mkDerivation {
  pname = "kde-${pluginName}";
  version = "1.1.0";
  src = fetchTarball {
    url = "https://github.com/ccatterina/plasmusic-toolbar/archive/refs/tags/v1.1.0.tar.gz";
    sha256 = "sha256:07wd1g2aik30cj5xkr33g023gb92806adimibznsng0xv895a985";
    #sha256 = lib.fakeSha256;
  };

  installPhase = ''
    runHook preInstall

    sharePath="$out/share/plasma/plasmoids/org.kde.${pluginName}"
    mkdir -p $sharePath
    mv src/* $sharePath

    runHook postInstall
  '';

  meta = with lib; {
    description = "A widget for KDE Plasma 6 that shows currently playing song information and provide playback controls.";
    homepage = "https://github.com/ccatterina/plasmusic-toolbar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
