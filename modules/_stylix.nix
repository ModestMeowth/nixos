{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/theme/catppuccin-mocha.yaml";
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
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme.override { color = "violet"; };
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    polarity = "dark";
  };
}
