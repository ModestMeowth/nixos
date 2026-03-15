{config, lib, pkgs, ...}:
let
  cfg = config.programs.elephant;
  settingsFormat = pkgs.formats.toml {};
  defaultProviders = [
    "bluetooth"
    "bookmarks"
    "calc"
    "clipboard"
    "desktopapplications"
    "files"
    "menus"
    "providerlist"
    "runner"
    "snippets"
    "symbols"
    "todo"
    "unicode"
    "websearch"
    "windows"
    "bitwarden"
    "1password"
    "nirisessions"
    "niriactions"
  ];
in
{
  options.programs.elephant = {
    enable = lib.mkEnableOption "Elephant launcher backend";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.elephant;
      defaultText = lib.literalExpression "pkgs.elephant";
      description = "The elephant package to use.";
    };

    providers = lib.mkOption {
      type = lib.types.listOf (lib.types.str);
      default = defaultProviders;
      example = defaultProviders;
      description = ''
        List of built-in providers to enable
      '';
    };

    installService = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Create a systemd service for elephant.";
    };

    settings = lib.mkOption {
      type = lib.types.submodule {
        freeformType = settingsFormat.type;
      };
      default = {};
      example = lib.literalExpression ''
        {
          auto_detect_launch_prefix = false;
        }
      '';
      description = ''
        elephant/elephant.toml run `elephant generatedoc` to view available options.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    systemd.user.services.elephant = lib.mkIf cfg.installService {
      Unit = {
        Description = "Elephant launcher backend";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.elephant}/bin/elephant";
        Restart = "on-failure";
        RestartSec = 1;

        X-Restart-Triggers = [
          (builtins.hashString "sha256" (builtins.toJSON {
            inherit (cfg) settings providers;
          }))
        ];

        ExecStopPost = "${pkgs.coreutils}/bin/rm -f /tmp/elephant.sock";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    xdg.configFile = lib.mkIf (cfg.settings != {}) {
      "elephant/elephant.toml".source = settingsFormat.generate "elephant.toml" cfg.settings;
    };
  };
}
