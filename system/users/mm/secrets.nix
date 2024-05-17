{config, ...}: {
  age.secrets = {
    tofu = {
      file = "${config.users.users.mm.home}/secrets/tofu.age";
      mode = "600";
      owner = "mm";
    };
    minio = {
      file = "${config.users.users.mm.home}/secrets/minio.age";
      mode = "600";
      owner = "mm";
    };
  };
}
