{lib, ...}:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.desktop.app-image = {
    nixos = {
      programs.appimage = {
        enable = true;
        binfmt = mkDefault true;
      };
    };
  };
}
