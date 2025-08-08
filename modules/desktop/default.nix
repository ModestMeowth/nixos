{ lib, pkgs, ... }: {
  imports = [
    ./hyprland.nix
    ./theming.nix
  ];

  boot = {
    plymouth =
    let theme = "cybernetic";
    in {
      enable = true;
      theme = theme;
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ theme ];
        })
      ];
    };

    consoleLogLevel = lib.mkDefault 3;
    initrd.verbose = lib.mkDefault false;
    kernelParams = lib.mkDefault [ "quiet" "splash" "boot.shell_on_fail" "udev.log_priority" "rd.systemd.show_status=auto" ];
  };

  environment.systemPackages = with pkgs; [
    bluez
    blueman
    bluez-tools
    libsForQt5.kdeconnect-kde
    pwvucontrol
    unstable.wiremix
    xdg-utils
  ];

  security.rtkit.enable = true;

  services = {
    blueman.enable = true;
    pipewire.enable = true;
  };
}
