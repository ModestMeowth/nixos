{ pkgs, ... }: {
  imports = [
    ./audio.nix
    ./fonts.nix
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kitty
    wl-clipboard
  ];
}
