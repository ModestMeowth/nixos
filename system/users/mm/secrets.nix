{inputs, ...}: {
  age.secrets = {
    tofu = {
      file = "${inputs.mm.outputs.secrets}/tofu.age";
      mode = "600";
      owner = "mm";
    };
    minio = {
      file = "${inputs.mm.outputs.secrets}/minio.age";
      mode = "600";
      owner = "mm";
    };
  };
}
