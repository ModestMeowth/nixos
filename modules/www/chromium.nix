{ den, inputs, ... }:
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

        xdg.dataFile."applications/chromium-work.desktop".source = inputs.self + /dotfiles/applications/chromium-work.desktop;
      };

  };
}
