{
  jetbrains-mono,
  kitty,
  nerd-fonts,

  makeWrapper,
  symlinkJoin,
  lib,
}:
symlinkJoin rec {
  name = "kitty";
  buildInputs = [
    jetbrains-mono
    nerd-fonts.symbols-only
  ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/kitty \
      --set KITTY_CONFIG_DIRECTORY "${../kitty}" \
      --prefix PATH : ${lib.makeBinPath buildInputs}
  '';

  paths = [ kitty ];
}
