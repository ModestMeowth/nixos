{
  config,
  inputs,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    (_: _: {
      terminaltexteffects = inputs.terminaltexteffects.packages.${config.nixpkgs.system}.default;
    })
  ];

  home.packages = [ pkgs.terminaltexteffects ];
}
