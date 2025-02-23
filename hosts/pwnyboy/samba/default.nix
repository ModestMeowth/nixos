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

      "mangled names" = "no";
      "vfs objects" = "catia";
      "catia:mappings" = "0x3a:0x5f";
    };

    samba-wsdd.enable = true;
    samba-wsdd.openFirewall = true;
  };
}
