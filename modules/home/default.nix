{
  inputs,
  ...
}: {

  imports = [
    ./common.nix
  ];

  home.file."justfile".source = "${inputs.mm.outputs.dotfiles}/justfile-nixos";
}
