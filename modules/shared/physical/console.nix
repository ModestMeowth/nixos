{ lib, pkgs, ... }: {
  console.colors = [
    "282a36" # black
    "ff5555" # red
    "50fa7b" # green
    "f1fa8c" # yellow
    "80bfff" # blue
    "ff79c6" # magenta
    "8be9fd" # cyan
    "f8f8f2" # white
    "6272a4" # bright black
    "ff5555" # bright red
    "50fa7b" # bright green
    "f1fa8c" # bright yellow
    "80bfff" # bright blue
    "ff79c6" # bright magenta
    "8be9fd" # bright cyan
    "ffffff" # bright white
  ];

  services.kmscon = {
    enable = false;

    extraConfig = ''
      palette=custom

      palette-black=40,42,54
      palette-red=255,85,85
      palette-green=80,250,123
      palette-yellow=241,250,140
      palette-blue=128,191,255
      palette-magenta=255,121,198
      palette-cyan=139,233,253
      palette-light-grey=248,248,242
      palette-dark-grey=98,114,164
      palette-light-red=255,85,85
      palette-light-green=80,250,123
      palette-light-yellow=241,250,140
      palette-light-blue=128,191,255
      palette-light-magenta=255,121,198
      palette-light-cyan=139,233,253
      palette-white=255,255,255

      palette-background=40,42,54
      palette-foreground=248,248,242

      font-size=10
    '';

    fonts = [{
      name = "0xProto Nerd Font Mono";
      package = pkgs.nerd-fonts._0xproto;
    }];
  };
}
