{
  den.aspects.desktop._.sddm = {
    nixos =
      { config, lib, ... }:
      let
        fonts = config.theming.fonts;
      in
      {
        catppuccin.sddm = {
          font = fonts.sansSerif.name;
          loginBackground = true;
          userIcon = true;
        };

        services = {
          displayManager.sddm = {
            enable = true;
            wayland.enable = true;
            autoLogin.relogin = lib.mkDefault true;
            autoNumlock = true;
          };
        };
      };
  };
}
