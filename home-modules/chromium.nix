{pkgs, ...}:
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
      commandLineArgs = [
        "--oauth2-client-id=77185425430.apps.googleusercontent.com"
        "--oauth2-client-secret=OTJgUOQcT7lO7GsGZq2G4IlT"
      ];
    };
  };
}
