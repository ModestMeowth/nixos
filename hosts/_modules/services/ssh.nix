{ config, lib, ... }: with lib; let
  cfg = config.modules.services.ssh;
in
{
  options.modules.services.ssh.enable = mkEnableOption "ssh";

  config = mkIf cfg.enable {
    programs.ssh.extraConfig = # sshconfig
      ''
        Host *
          SendEnv TMUX ZELLIJ
      '';

    services.openssh = {
      enable = true;

      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
      settings.PermitRootLogin = "no";

      extraConfig = # sshdconfig
        ''
          AcceptEnv ZELLIJ TMUX
        '';
    };
  };
}
