{inputs, pkgs, ...}: {

  imports = [
    ./common.nix
  ];

  home = {
    file."justfile".text = /*just*/ ''
      default:
        @just --list
    '';
    packages = with pkgs; [
      nh
    ];
  };
}
