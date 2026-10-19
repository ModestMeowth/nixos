{ den, ... }:
{
  den.aspects.apps._.ventoy =
    {pkgs, ...}:
    {
      includes = [
        (den._.unfree [
          "ventoy"
        ])
        (den._.insecure [
          "ventoy-${pkgs.ventoy.version}"
        ])
      ];

      nixos = {
        environment.systemPackages = with pkgs; [ ventoy-full ];  
      };
    };
}
