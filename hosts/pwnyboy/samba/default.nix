{
  imports = [ ./media.nix ];

  services = {
    samba.enable = true;
    samba.openFirewall = true;

    samba.settings.global = {
      "workgroup" = "WORKGROUP";
      "server string" = "pwnyboy";
      "netbios name" = "pwnyboy";

      "security" = "user";
      "hosts allow" = "192.168.0. 127.0.0.1 localhost";
      "hosts deny" = "0.0.0.0/0";
      "guest account" = "nobody";
      "map to guest" = "bad user";
    };

    samba-wsdd.enable = true;
    samba-wsdd.openFirewall = true;
  };
}
