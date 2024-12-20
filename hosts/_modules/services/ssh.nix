{ config, lib, ... }:
let
  cfg = config.services.openssh;
in
{
  programs.ssh.extraConfig = # sshconfig
    ''
      Host *
        SendEnv TMUX ZELLIJ
    '';

  services.openssh = lib.mkIf cfg.enable {
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";

    extraConfig = # sshdconfig
      ''
        AcceptEnv ZELLIJ TMUX
      '';
  };
}
