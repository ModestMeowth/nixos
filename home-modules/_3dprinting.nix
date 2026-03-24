{pkgs, ...}:
{
  home.packages = with pkgs; [
    blender
    openscad
    orca-slicer
  ];
}
