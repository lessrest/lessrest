{ lib
, stdenv
, makeWrapper
, gnugrep
, nodejs-10_x
, tmux
, st
, dmenu2
}:

stdenv.mkDerivation rec {
  name = "kb2-${version}";
  version = "0.5";
  src = ./.;
  nativeBuildInputs = [makeWrapper];
  installPhase =
    let
      path = lib.makeBinPath [
        gnugrep tmux st dmenu2
      ];
    in ''
      mkdir -p $out/{bin,lib/kb2}
      cp kb2-{choose-user,launch,terminal,write-line} $out/bin/
      cp -r node_modules kb2-chat $out/lib/kb2/
      ln -s $out/lib/kb2/kb2-chat $out/bin/
      for x in $out/bin/kb2-*; do
        wrapProgram "$x" --prefix PATH : "${path}"
      done
    '';
}
