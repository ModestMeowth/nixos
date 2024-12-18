{ config, lib, ... }: with lib; let
  cfg = config.services.openssh;
in
{
  config = mkIf cfg.enable {
    programs.ssh.extraConfig = # sshconfig
      ''
        Host *
          SendEnv TMUX ZELLIJ
      '';

    services.openssh = {
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
