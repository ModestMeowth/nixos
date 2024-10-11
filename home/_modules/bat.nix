{inputs, pkgs, ...}: {
  programs.bat = {
    enable = true;
    themes.Dracula.src = inputs.dracula.outputs.bat;

    extraPackages = with pkgs.bat-extras; [
      batman
      batdiff
      prettybat
    ];
  };
}
