{ inputs, ... }:
{
  unstable-packages = final: prev: {
    unstable = import inputs.unstable {
      inherit (final) system;
      config.allowUnfree = true;
      overlays = [ ];
    };
  };

  devshell = inputs.devshell.overlays.default;
}
