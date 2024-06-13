{pkgs, ...}: {
  imports = (let p = ../../../modules/home; in [
    (p)
    (p+"/gtk")
    (p+"/neovim/plugins/lsp")
    (p+"/term/wezterm")
    (p+"/gaming/retroarch.nix")
  ]);

  home = {
    username = "mm";
    homeDirectory = "/home/mm";

    packages = with pkgs; [
      wezterm
    ];
  };
}
