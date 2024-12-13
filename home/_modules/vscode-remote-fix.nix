{config, lib, pkgs, ...}: with lib; let
  cfg = config.modules.vscode-remote-fix;
in {
  options.modules.vscode-remote-fix.enable = mkEnableOption "vscode-remote-fix";

  config.systemd.user.services.vscode-remote-fix = mkIf cfg.enable {
    Unit.Description = "VSCode Remote Fix";
    Install.WantedBy = ["default.target"];
    Service.ExecStart = "${pkgs.writeShellScript "vscode-remote-fix" #bash
      ''
        for i in ~/.vscode-server/bin/*; do
          echo "Fixing vscode-server in $i..."
          ln -sf ${pkgs.nodejs}/bin/node $i/node
        done
      ''
    }";
  };
}
