{pkgs, ...}: {
  imports = (let p = ../../modules/home; in [
    (p)
    (p+"/standalone.nix")
  ]);

  home = {
    username = "mm";
    homeDirectory = "/home/mm";

    packages = with pkgs; [
    ];
  };
}
