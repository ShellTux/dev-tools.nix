{ bat, symlinkJoin }:
symlinkJoin {
  name = "bat";
  paths = [ bat ];
}
