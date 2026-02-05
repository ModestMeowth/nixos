{lib, pkgs, ...}: {
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

    plymouth = {
      enable = lib.mkDefault true;
      theme = "catppuccin-macchiato";
      themePackages = [(
        pkgs.catppuccin-plymouth.override {
          variant = "macchiato";
      })];
    };
  };

  environment.systemPackages = with pkgs; [
    kitty
    pwvucontrol
    wiremix
    xdg-utils
    (catppuccin-sddm.override {
      flavor = "macchiato";
      accent = "mauve";
      font = "Caskaydia Nerd Font";
      fontSize = "9";
    })
  ];

  fonts = {
    packages = with pkgs.nerd-fonts; [
      _0xproto
      caskaydia-cove
      noto
      symbols-only
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["0xProto Nerd Font Propo"];
        sansSerif = ["Caskaydia Cove Nerd Font"];
        monospace = ["0xProto Nerd Font Mono"];
        emoji = ["Noto-Color-Emoji"];
      };
    };
  };

  hardware.bluetooth.enable = true;

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    blueman.enable = true;

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
        theme = "catppuccin-macchiato-mauve";
      };
    };

    pipewire.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
