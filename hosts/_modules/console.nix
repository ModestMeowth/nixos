{config, lib, ...}: with lib; let
  cfg = config.modules.hw.cpu;
in {
  config.console = mkIf (cfg != "wsl") {
    colors = [
      "21222c" # black
      "ff5555" # red
      "50fa7b" # green
      "f1fa8c" # yellow
      "bd93f9" # blue
      "ff79c6" # magenta
      "8be9fd" # cyan
      "f8f8f2" # white

      "6272a4" # bright black
      "ff6e6e" # bright red
      "69ff94" # bright green
      "ffffa5" # bright yellow
      "d6acff" # bright blue
      "ff92df" # bright magenta
      "a4ffff" # bright cyan
      "ffffff" # bright white
    ];
  };
}
