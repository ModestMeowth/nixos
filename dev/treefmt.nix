{inputs, ...}:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      keep-sorted.enable = true;
      nixfmt = {
        enable = true;
        width = 120;
        strict = true;
      };
    };
  };
}
