{ pkgs, ... }:
{
  modules.neovim.profile = "development";
  programs.gh.enable = true;
  home.packages = [ pkgs.commitizen ];

  systemd.user.services.vscode-remote-workaround = {
    Unit = {
      Description = "VSCode Remote Workaround";
    };

    Install = {
      WantedBy = ["default.target"];
    };

    Service = {
      ExecStart = "${pkgs.writeShellScript "vscode-remote-workaround" #bash
        ''
          for i in ~/.vscode-server/bin/*; do
            echo "Fixing vscode-server in $i..."
            ln -sf ${pkgs.nodejs}/bin/node $i/node
          done
        ''}";
    };
  };
}
