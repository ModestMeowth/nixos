{config, lib, ...}: {
  config = lib.mkIf (config.hm-mm.shell.fish.profile == "multiplexer") {
    hm-mm.shell.fish = {
      enable = true;
      direnv = true;
      eza = true;
      fzf = true;
      starship = true;
      zellij = true;
      zoxide = true;
    };
  };
}
