{inputs, ...}:
let
  scheme = pkgs: {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    cursor = {
      package = pkgs.catppuccin-cursors.mochaMauve;
      name = "catppuccin-mocha-mauve-cursors";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-mono;
        name = "Caskaydia Cove Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "Caskaydia Cove Nerd Font";
      };

      sizes.terminal = 11;
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme.override { color = "violet"; };
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    overlays.enable = false;
    polarity = "dark";
  };
in
{
  den.default = {
    nixos =
      {pkgs, ...}:
      {
        imports = [ inputs.stylix.nixosModules.stylix ];
        stylix = (scheme pkgs) // {
          homeManagerIntegration.autoImport = false;
        };
      };

    homeManager =
      {pkgs, ...}:
      {
        imports = [ inputs.stylix.homeModules.stylix ];
        stylix = scheme pkgs;
      };
  };
}
