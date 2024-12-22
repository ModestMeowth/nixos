{
  services.samba.settings.media = {
    "path" = "/persist/data/media";
    "public" = "yes";
    "browsable" = "yes";
    "read only" = "no";
    "writeable" = "yes";
    "guest ok" = "no";
    "create mask" = "0644";
    "directory mask" = "0755";
    "force user" = "mm";
    "force group" = "users";
  };
}
