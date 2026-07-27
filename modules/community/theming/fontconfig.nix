{
  theming.fontconfig = {
    nixos = {
      imports = [ ./_targets/fontconfig.nix ];
    };

    homeManager = {
      imports = [ ./_targets/fontconfig.nix ];
    };
  };
}
