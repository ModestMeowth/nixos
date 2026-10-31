{den, ...}:
{
  den.aspects.apps._.ventoy =
    {host, ...}:
    let
      desktop = host.hasAspect den.aspects.desktop;
      plasma = host.hasAspect den.aspects.desktop._.plasma;

      ventoyVersion = "1.1.18";
      ventoyPkg = if desktop then
        if plasma then
          "ventoy-full-qt"
        else
          "ventoy-full-gtk"
      else
        "ventoy-full"
      ;
    in
    {
      includes = [
        (den._.unfree [
          "ventoy"
          "ventoy-gtk3"
          "ventoy-qt5"
        ])
        (den._.insecure [
          "ventoy-${ventoyVersion}"
          "ventoy-gtk3-${ventoyVersion}"
          "ventoy-qt5-${ventoyVersion}"
        ])
      ];

      nixos =
        {pkgs, ...}:
        {
          environment.systemPackages = [ pkgs.${ventoyPkg} ];
        };
    };
}
