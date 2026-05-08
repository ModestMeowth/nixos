{
  perSystem =
    {config, inputs', pkgs, ...}:
    {
      devShells.default = pkgs.mkShell {
        packages = [
          inputs'.home-manager.packages.default
          config.formatter
        ]
        ++ config.pre-commit.settings.enabledPackages;

        inputsFrom = [ config.treefmt.build.devShell ];
    };
  };
}
