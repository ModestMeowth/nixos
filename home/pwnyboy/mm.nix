{pkgs, ...}: {
  imports = [
    ../../modules
    ../../modules/standalone.nix
  ];

  home = {
    username = "mm";
    homeDirectory = "/home/mm";

    packages = with pkgs; [
    ];
  };
}
