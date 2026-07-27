{
  den.aspects.desktop._.gnome = {
    nixos =
      { pkgs, ... }:
      {
        services = {
          displayManager.gdm.enable = true;
          desktopManager.gnome.enable = true;

          gnome = {
            core-apps.enable = false;
            core-os-services = true;
            games.enable = false;
          };
        };

        environment.gnome.excludePackages = with pkgs; [
          gnome-tour
          gnome-user-docs
        ];
      };
  };
}
