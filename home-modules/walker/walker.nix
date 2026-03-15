{config, lib, pkgs, ...}:
let
  inherit (builtins) fromTOML readFile;

  cfg = config.programs.walker;
  settingsFormat = pkgs.formats.toml {};
in
{
  options.programs.walker = {
    enable = lib.mkEnableOption "walker";

    package = lib.mkOption {
      type = lib.types.package;
      default =  pkgs.walker;
    };

    installService = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Create a systemd service for elephant";
    };

    settings = lib.mkOption {
      type = lib.types.submodule {
        freeformType = settingsFormat.type;
      };
      default = {};
      example = lib.literalExpression ''
        {
          theme = "default";
        }
      '';
      description = ''
        Configuration options for walker.

        See the default configuration for available options: <https://github.com/abenz1267/walker/blob/master/resouces/config.toml>
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    programs.elephant.enable = true;

    systemd.user.services.walker = lib.mkIf cfg.installService {
      Unit = {
        Description = "Walker - Application runner";
        ConditionEnvironment = "WAYLAND_DISPLAY";
        After = [
          "graphical-session.target"
          "elephant.service"
        ];

        Requires = ["elephant.service"];
        PartOf = ["graphical-session.target"];
        X-Restart-Triggers = [
          (builtins.hashString "sha256" (builtins.toJSON {
            inherit (cfg) settings;
          }))
        ];
      };

      Service = {
        ExecStart = "${cfg.package}/bin/walker  --gapplication-service";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    xdg.configFile = lib.mkIf (cfg.settings != {}) {
      "walker/config.toml".source = settingsFormat.generate "walker-config.toml" cfg.settings;
    };
  };
}
