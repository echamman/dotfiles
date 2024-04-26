{ pkgs, lib, stdenv, ... }:

let
  pluginName = "ginti";
in
stdenv.mkDerivation {
  pname = "kde-${pluginName}";
  version = "0.5";
  src = fetchTarball {
    url = "https://github.com/dhruv8sh/plasma6-desktopindicator-gnome/archive/refs/tags/v0.5.tar.gz";
    sha256 = "sha256:1vqkz68fnb15690vjhxwzqyby8z86b65g040r58kwx40q489gb0v";
  };

  # Without this plasma can't properly find the format
  patches = [ ./metadata.patch ];

  installPhase = ''
    runHook preInstall

    sharePath="$out/share/plasma/plasmoids/org.kde.plasma.${pluginName}"
    mkdir -p $sharePath
    mv * $sharePath

    runHook postInstall
  '';

  meta = with lib; {
    description = " Plasma 6 applet in order to show virtual desktops in a minimal way, Gnome style";
    homepage = "https://github.com/dhruv8sh/plasma6-desktopindicator-gnome";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
