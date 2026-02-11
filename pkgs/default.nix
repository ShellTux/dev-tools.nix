{
  pkgs,
  inputs',
  system,
  ...
}:
let
  inherit (pkgs) callPackage;
  nixvim' = inputs'.nixvim.legacyPackages;
  nixvimModule = {
    inherit system pkgs;
    module = import ./nixvim;
    extraSpecialArgs = {
      inherit pkgs;
      leader-key = " ";
      noice.enable = true;
    };
  };
in
{
  packages = rec {
    bat = callPackage ./bat { };
    default = pkgs.hello;
    kitty = callPackage ./kitty { };
    neovim = nixvim;
    nixvim = nixvim'.makeNixvimWithModule nixvimModule;
    nvim = nixvim;
    vim = callPackage ./vim { };
  };
}
