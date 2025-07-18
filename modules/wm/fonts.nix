{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    nerd-fonts.droid-sans-mono
    nerd-fonts.noto
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-sans
    nerd-fonts.ubuntu-mono
    unifont
  ];
}
