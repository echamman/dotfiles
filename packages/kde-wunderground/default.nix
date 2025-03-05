{ pkgs, lib, stdenv, ... }:

let
  pluginName = "plasmoid-wunderground";
in
stdenv.mkDerivation {
  pname = "kde-${pluginName}";
  version = "3.4.1";
  src = pkgs.fetchFromGitHub {
    owner = "k-donn";
    repo = "plasmoid-wunderground";
    rev = "34521dadb9445586277bf8733a9d75a0bd8bb7c0";
    hash = "sha256-qLfzq+e1DQ/VDyDiZ2dnK9cqz3JNStIXWDX/WbMwGDM=";
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
