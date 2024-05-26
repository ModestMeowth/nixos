{
  imports = [../../../modules/system/cifs.nix];

  age.secrets.smb-pwnyboy.file = /home/mm/.secrets/smb-pwnyboy.age;

  fileSystems."/persist/share" = {
    fsType = "cifs";
    device = "//pwnyboy/share";
    options = [
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.mount-timeout=5s"
      "dir_mode=0750"
      "file_mode=0640"
      "uid=1001"
      "gid=100"
      "credentials=/run/agenix/smb-pwnyboy"
    ];
  };
}
