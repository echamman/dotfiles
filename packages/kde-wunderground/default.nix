{ pkgs, lib, stdenv, ... }:

let
  pluginName = "plasmoid-wunderground";
in
stdenv.mkDerivation {
  pname = "kde-${pluginName}";
  version = "0.1.4";
  src = pkgs.fetchFromGitHub {
    owner = "k-donn";
    repo = "plasmoid-wunderground";
    rev = "a28e32d22d6ce71ed684403ca90ea92e1c71de73";
    hash = "sha256-G4uNxi1/pi8XIPgiY4r0FCxvF0oUBxI8hVEbVSGYsrI=";
  };

  installPhase = ''
    runHook preInstall

    sharePath="$out/share/plasma/plasmoids/com.github.k-donn.${pluginName}"
    mkdir -p $sharePath
    mv plasmoid/* $sharePath

    runHook postInstall
  '';

  meta = with lib; {
    description = "Weather Widget for Plasma 6";
    homepage = "https://github.com/k-donn/plasmoid-wunderground";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
