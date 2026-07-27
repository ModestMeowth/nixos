{ den, ... }:
{
  den.aspects.desktop = {
    includes = [
      (den._.unfree [
        "corefonts"
        "vista-fonts"
      ])
    ];

    nixos =
      { pkgs, ... }:
      {
        fonts.packages = with pkgs; [
          corefonts
          google-fonts
          vista-fonts
          wineWow64Packages.fonts
        ];
      };

    homeManager =
      { ... }:
      {

      };
  };
}
