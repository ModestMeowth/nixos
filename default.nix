(import (
  let
    inherit (lock.nodes.flake-compat.locked) narHash rev;
    lock = builtins.fromJSON (builtins.readFile ./dev/flake.lock);
  in
  fetchTarball {
    url = "https://github.com/nixos/flake-compat/archives${rev}.tar.gz";
    sha256 = narHash;
  }
) { src = ./.;}).defaultNix
