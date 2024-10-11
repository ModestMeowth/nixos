{config, lib, pkgs, ...}: {
  imports = [
    ./integrations
    ./basic.nix
    ./multiplexer.nix
  ];

  options.hm-mm.shell.fish = {
    enable = lib.mkEnableOption "fish";

    profile = lib.mkOption {
      type = lib.types.enum [
        "basic"
        "multiplexer"
      ];
    };
  };

  config = lib.mkIf config.hm-mm.shell.fish.enable {
    programs.fish = {
      enable = true;

      plugins = with pkgs.fishPlugins; [
        {
          name = "puffer";
          src = puffer.src;
        }
      ];

      interactiveShellInit = /* fish */ ''
        set -g fish_greeting
        fish_vi_key_bindings
      '';

      shellAbbrs = {
        ssh = "mosh";
        j = "just";
        g = "git";
        ga = "git add";
        clone = "git clone";
        co = "git checkout";
        cz = "git cz c";
      };
    };
  };
}
