{inputs, lib, pkgs, ...}: with lib; {
  programs.neovim.enable = true;
  programs.gh.enable = true;

  home.packages = [
    pkgs.commitizen
    pkgs.nh
  ];

  home.file."justfile".source = mkForce "${inputs.mm.outpus.dotfiles}/justfile-ubuntu";
}
