{ den, ... }:
{
  den.aspects.apps._.ventoy =
    let
      ventoyVersion = "1.1.18";
    in
    {
      includes = [
        (den._.unfree [
          "ventoy"
        ])
        (den._.insecure [
          "ventoy-${ventoyVersion}"
        ])
      ];

      nixos =
      {pkgs, ...}:
        {
          environment.systemPackages = with pkgs; [ ventoy-full ];  
        };
    };
}
