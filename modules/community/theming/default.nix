{
  theming.default = {
    nixos = {
      imports = [ ./_targets/polarity.nix ];
    };

    homeManager = {
      imports = [ ./_targets/polarity.nix ];
    };
  };
}
