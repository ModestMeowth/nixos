{config, lib, ...}: {
  options.hostConfig.cluster.k3s-rook = lib.mkEnableOption "k3s-rook";

  config = lib.mkIf config.hostConfig.cluster.k3s-rook {
    boot.kernelModules = [ "rdb" ];
  };
}
