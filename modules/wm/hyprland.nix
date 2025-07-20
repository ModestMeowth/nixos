{ pkgs, lib, ... }: {
  imports = [
    ./audio.nix
    ./fonts.nix
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    hyprsunset
    kitty
    libnotify
    wl-clipboard
  ];
}
