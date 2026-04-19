{pkgs, ...}:
{
  home.packages = with pkgs; [
    blender
    openscad
    orca-slicer
    nanum
    nanum-gothic-coding
  ];
}
