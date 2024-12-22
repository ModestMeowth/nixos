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
      "guest account" = "nobody";
      "map to guest" = "bad user";
    };

    samba-wsdd.enable = true;
    samba-wsdd.openFirewall = true;
  };
}
