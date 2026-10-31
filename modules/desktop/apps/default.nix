{
  den.aspects.desktop =
    {
      nixos =
        { pkgs, ... }:
        {
          environment.systemPackages = with pkgs; [
            kitty
          ];

          services.gvfs.enable = true;
        };

      homeManager =
        { pkgs, ... }:
        {
          home.packages = with pkgs; [
            gnome-calculator
            imv
            libnotify
            nautilus
            nautilus-open-any-terminal
            ncdu
            signal-desktop
            wiremix
            wireshark
          ];

          services = {
            kdeconnect = {
              enable = true;
              indicator = true;
            };
          };
        };
    };
}
