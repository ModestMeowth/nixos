{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    adwaita-fonts
    noto-fonts
    ubuntu-classic
    ubuntu-sans
    ubuntu-sans-mono
    unifont
  ] ++ ( with nerd-fonts; [
    _0xproto
    adwaita-mono
    caskaydia-cove
    caskaydia-mono
    droid-sans-mono
    noto
    ubuntu
    ubuntu-sans
    ubuntu-mono
  ]);
}
