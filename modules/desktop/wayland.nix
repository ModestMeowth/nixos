{ den, ... }:
{
  den.aspects.desktop._.wayland = {
    includes = [ den.aspects.desktop ];
    nixos =
      { pkgs, ... }:
      {
        programs = {
          dconf.enable = true;
        };

        environment = {
          sessionVariables = {
            NIXOS_OZONE_WL = "1";
            XCURSOR_SIZE = 24;
          };
          systemPackages = with pkgs; [
            waypipe
            wl-clipboard
          ];
        };
      };

    homeManager =
      { ... }:
      {

      };
  };
}
