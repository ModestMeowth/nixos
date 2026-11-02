{ den, ... }:
{
  den.aspects.www.chromium = {
    includes = with den.aspects; [
      (den._.unfree [
        "chromium"
        "chromium-unwrapped"
        "widevine-cdm"
      ])
    ];

    homeManager =
      { pkgs, ... }:
      {
        programs.chromium = {
          enable = true;
          extensions = [
            "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
            "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
            "mnjggcdmjocbbbhaepdhchncahnbgone" # Sponsorblock
          ];

          package = pkgs.chromium.override {
            enableWideVine = true;
          };
        };
      };
  };
}
