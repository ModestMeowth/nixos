{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.gaming;
in
{
  home.packages = lib.mkIf cfg.bottles [ pkgs.bottles ];
}
