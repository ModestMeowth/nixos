{
  config.services.samba = {
    openFirewall = true;

    settings.global = {
      "map to guest" = "bad user";
      "min protocol" = "SMB2";
    };
  };
}
