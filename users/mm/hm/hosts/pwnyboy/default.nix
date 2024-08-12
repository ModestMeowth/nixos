{inputs, lib, pkgs, ...}: {
  hm-mm = {
    editor.nvim.profile = "basic";
    githubKeys = true;
    git = {
      enable = true;
      commitizen = true;
      gh = true;
    };
    shell.fish.profile = "multiplexer";
  };

  home = {
    file."justfile".source = lib.mkForce "${inputs.mm.outputs.dotfiles}/justfile-ubuntu";
    packages = [ pkgs.nh ];
  };
}
