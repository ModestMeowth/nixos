{inputs, pkgs, ...}: {

  imports = [
    ./common.nix
  ];

  home = {
    file."justfile".source = "${inputs.mm.outputs.dotfiles}/justfile-ubuntu";
    packages = with pkgs; [
      nh
    ];
  };
}
