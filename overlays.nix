{ inputs, ... }: {
  nur = inputs.nur.overlays.default;

  additions = final: _: import ./packages {
    inherit inputs;
    pkgs = final;
  };

  unstable-packages = final: _: {
    unstable = import inputs.unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
}
