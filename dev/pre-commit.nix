{ inputs, ... }:
{
  imports = [ inputs.git-hooks.flakeModule ];

  perSystem =
    { config, lib, ... }:
    {
      pre-commit = {
        check.enable = true;

        settings.hooks = {
          deadnix = {
            enable = true;
            settings.noLambdaPatternNames = true;
          };
          editorconfig-checker.enable = true;
          pre-commit-hooks-ensure-sops.enable = true;
          treefmt = {
            enable = true;
            package = config.formatter;
          };
          typos = {
            enable = true;
            settings.config.default.extend-identifers = lib.genAttrs [ "substituters" ] lib.id;
          };
        };
      };
    };
}
