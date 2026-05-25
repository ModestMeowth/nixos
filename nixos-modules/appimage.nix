{ lib, ... }:
{
  programs.appimage = {
    enable = true;
    binfmt = lib.mkDefault true;
  };
}
