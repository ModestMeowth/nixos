{
  perSystem.treefmt = {
    projectRootFile = ".envrc";

    programs = {
      nixfmt = {
        enable = true;
        excludes = [ ".direnv" ];
      };

      deadnix = {
        enable = true;
        no-underscore = true;
      };

      fish_indent.enable = true;
      kdlfmt.enable = true;
      stylua.enable = true;
      taplo.enable = true;
      yamlfmt.enable = true;
    };

    settings.global.excludes = [
      "flake.lock"
      ".envrc"
      "**/.gitignore"
      "*/config/ghostty/*"
    ];
  };
}
