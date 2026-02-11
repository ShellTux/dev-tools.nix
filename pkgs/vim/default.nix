{
  vim,
  vimPlugins,
  vimUtils,
  makeWrapper,
  symlinkJoin,
}:
let
  inherit (builtins) readFile;
  inherit (vimUtils) vimrcFile;

  customRC = vimrcFile {
    customRC = readFile ./vimrc;
    packages.mvc.start = [
      vimPlugins.auto-pairs
      vimPlugins.catppuccin-vim
      vimPlugins.vim-airline
      vimPlugins.vim-indent-guides
      vimPlugins.vim-obsession
      vimPlugins.vim-polyglot
      vimPlugins.vim-repeat
    ];
  };
in
symlinkJoin {
  name = "vim";
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/vim \
      --add-flags "-u ${customRC}" \
  '';

  paths = [ vim ];
}
