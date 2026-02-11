{
  pkgs,
  ...
}:
let
  inherit (pkgs) callPackage;
in
{
  packages = {
    bat = callPackage ./bat { };
    default = pkgs.hello;
  };
}
