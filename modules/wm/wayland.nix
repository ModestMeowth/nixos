{
  den.aspects.desktop = {
    nixos =
      { pkgs, ... }:
      {
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
  };
}
