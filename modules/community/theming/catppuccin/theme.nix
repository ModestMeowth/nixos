{ inputs, lib, ... }:
let
  wallpaper = inputs.self + /assets/wall.png;
in
{
  theming.catppuccin = flavor: accent: {
    nixos = {
      imports = [
        inputs.catppuccin.nixosModules.default
        ./_kmscon.nix
      ];

      theming.polarity = if (flavor == "latte") then
        "light"
      else
        "dark";

      catppuccin = {
        enable = true;
        autoEnable = true;
        inherit flavor accent;
      };
    };

    homeManager =
      { pkgs, ... }:
      {
        imports = [
          inputs.catppuccin.homeModules.catppuccin
          ./_quickshell.nix
        ];

        theming.polarity = if (flavor == "latte") then
          "light"
        else
          "dark";

        catppuccin = {
          inherit accent flavor;

          enable = true;
          autoEnable = true;

          cursors.enable = lib.mkDefault true;

          kvantum.enable = false;
        };

        gtk.gtk3.theme = {
          name = lib.mkDefault "adw-gtk3";
          package = lib.mkDefault pkgs.adw-gtk3;
        };

        qt = {
          platformTheme.name = lib.mkDefault "qtct";

          style = {
            package = lib.mkDefault pkgs.darkly;
          };

          kde.settings.kdeglobalsUiSettings = {
            ColorScheme = lib.mkDefault "catppuccin-${flavor}-${accent}";
            IconTheme = lib.mkDefault "papirus-dark";
          };

          qt5ctSettings.Appearance.style = lib.mkDefault "Darkly";
          qt6ctSettings.Appearance.style = lib.mkDefault "Darkly";
        };

        dconf.settings = {
          "org/gnome/desktop/background" = {
            picture-uri = lib.mkDefault "${wallpaper}";
            picture-uri-dark = lib.mkDefault "${wallpaper}";
          };

          "org/gnome/desktop/screensaver" = {
            picture-uri = lib.mkDefault "${wallpaper}";
          };
        };
      };
  };
}
