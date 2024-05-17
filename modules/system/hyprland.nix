{pkgs, ...}: {
  imports = [
    ./sddm.nix
    ./fonts.nix
  ];

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  environment.systemPackages = with pkgs; [
    foot
    brightnessctl
    hypridle
    hyprlock
    wl-clipboard
    clipman
    wlsunset
    wofi
    waybar
    xdg-utils
  ];
}
