{config, lib, pkgs, ...}:
let
  cfg = config.fleet;
in
{
  boot = lib.mkIf (cfg.isLaptop || cfg.isDesktop) {
    plymouth = {
      enable = true;
      theme = "catppuccin-macchiato";
      themePackages = [(
        pkgs.catppuccin-plymouth.override {
          variant = "macchiato";
      })];
    };

    consoleLogLevel = lib.mkDefault 3;
    initrd.verbose = lib.mkDefault false;
    kernelParams = lib.mkDefault [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority"
      "rd.systemd.show_status=auto"
    ];
  };
}
