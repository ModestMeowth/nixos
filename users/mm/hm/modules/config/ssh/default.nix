{inputs, config, lib, ...}: {
  options.hm-mm.githubKeys = lib.mkEnableOption "github-keys";

  config = lib.mkIf config.hm-mm.githubKeys {
    home.file.".local/cache/ssh/authorized_keys" = {
      source = inputs.mm.outputs.keys;
      onChange = ''
        rm -rf ${config.home.homeDirectory}/.ssh/authorized_keys
        cp ${config.home.homeDirectory}/.local/cache/ssh/authorized_keys ${config.home.homeDirectory}/.ssh/authorized_keys
        chmod 0600 ${config.home.homeDirectory}/.ssh/authorized_keys
      '';
    };
  };
}
