{ pkgs, ...}:
pkgs.mkShell { buildInputs = [ pkgs.just ]; }
