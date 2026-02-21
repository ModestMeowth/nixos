{
  config,
  lib,
  pkgs,
  ...
}:
{
  catppuccin.sddm = {
    font = config.stylix.fonts.sansSerif.name;
    loginBackground = true;
    userIcon = true;
  };

  boot = {
    consoleLogLevel = lib.mkDefault 3;
    initrd.verbose = lib.mkDefault false;
    kernelParams = lib.mkDefault [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority"
      "rd.systemd.show_status=auto"
    ];

    plymouth.enable = lib.mkDefault true;
  };

  environment.systemPackages = with pkgs; [
    kitty
    pulseaudio # for pactl
    pwvucontrol
    wiremix
    xdg-utils
  ];

  hardware.bluetooth.enable = true;

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    displayManager = {
      autoLogin = {
        enable = lib.mkDefault true;
        user = lib.mkDefault "mm";
      };

      sddm = {
        enable = true;
        wayland.enable = true;
        autoLogin.relogin = lib.mkDefault true;
        autoNumlock = true;
      };
    };

    pipewire.enable = true;
  };

  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "kitty.desktop" ];
  };

  stylix.targets = {
    font-packages.enable = true;
    fontconfig.enable = true;
  };
}
