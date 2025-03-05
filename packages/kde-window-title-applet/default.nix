{ pkgs, lib, stdenv, ... }:

let
  pluginName = "windowtitle";
in
stdenv.mkDerivation {
  pname = "kde-${pluginName}";
  version = "0.9.0";
  src = pkgs.fetchFromGitHub {
    owner = "dhruv8sh";
    repo = "plasma6-window-title-applet";
    rev = "a6eaf5086a473919ed2fffc5d3b8d98237c2dd41";
    hash = "sha256-pFXVySorHq5EpgsBz01vZQ0sLAy2UrF4VADMjyz2YLs=";
  };
  # Without this plasma can't properly find the format
  #patches = [ ../kde-ginti/metadata.patch ];

  installPhase = ''
    runHook preInstall

    sharePath="$out/share/plasma/plasmoids/org.kde.${pluginName}"
    mkdir -p $sharePath
    mv * $sharePath

    runHook postInstall
  '';

  meta = with lib; {
    description = " A Plasma 6 port of the Window Title Applet for Latte Dock by the legendary Psifidotos.";
    homepage = "https://github.com/dhruv8sh/plasma6-window-title-applet";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
