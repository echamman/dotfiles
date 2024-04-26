{ pkgs, lib, stdenv, ... }:

let
  pluginName = "windowtitle";
in
stdenv.mkDerivation {
  pname = "kde-${pluginName}";
  version = "0.5.5";
  src = pkgs.fetchFromGitHub {
    owner = "dhruv8sh";
    repo = "plasma6-window-title-applet";
    rev = "6d6b939bb8138a8b1640cf2f6d395a3030d7bbaa";
    hash = "sha256-dfJcRbUubv3/1PAWCFtNWzc8nyIcgTW39vryFLOOqzs=";
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
