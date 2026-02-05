{ lib, ... }:
{
  sops = {
    defaultSopsFile = ./secrets.sops.yaml;
    age.generateKey = true;
    age.sshKeyPaths = lib.mkDefault [ "/persist/etc/sops/agekey" ];
  };
}
