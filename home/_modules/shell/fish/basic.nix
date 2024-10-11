{config, lib, ...}: {
  config = lib.mkIf (config.hm-mm.shell.fish.profile == "basic") {
    hm-mm.shell.fish = {
      enable = true;
      direnv = true;
      eza = true;
      fzf = true;
      starship = true;
      zoxide = true;
    };
  };
}
