{
  imports = (let p = ../../modules/home; in [
    (p)
    (p+"/neovim/plugins/lsp/cmp.nix")
    (p+"/ssh.nix")
  ]);

  home.username = "mm";
  home.homeDirectory = "/home/mm";
}
