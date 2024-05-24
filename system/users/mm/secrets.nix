{config, ...}: {
  age.secrets = {
    tofu = {
      file = "/home/mm/.secrets/tofu.age";
      mode = "600";
      owner = "mm";
    };
    minio = {
      file = "/home/mm/.secrets/minio.age";
      mode = "600";
      owner = "mm";
    };
  };
}
