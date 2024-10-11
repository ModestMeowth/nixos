{config, lib, ...}: {
  imports = [
    ./commitizen.nix
    ./gh.nix
    ./lazygit.nix
  ];

  options.hm-mm.git.enable = lib.mkEnableOption "git";

  config = lib.mkIf config.hm-mm.git.enable {
    programs.git = {
      enable = true;
      userName = "Daniel Eberle";
      userEmail = "daniel.j.eberle@protonmail.com";
      extraConfig = {
        color = {
          ui = "auto";
          branch = {
            current = "yellow reverse";
            local = "yellow";
            remote = "green";
          };
          diff = {
            frag = "magenta bold";
            meta = "yellow bold";
            new = "green";
            old = "red";
          };
          status = {
            added = "yellow";
            changed = "green";
            untracked = "cyan";
          };
        };
        core.editor = "nvim";
        init.defaultBranch = "main";
      };
    };
  };
}
