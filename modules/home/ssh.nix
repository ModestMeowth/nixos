{config, inputs, ...}: {
  home.file.".local/cache/ssh/authorized_keys" = {
    source = "${inputs.mm.outputs.keys}";
    onChange = ''
      rm -f ${config.home.homeDirectory}/.ssh/authorized_keys
      cp ${config.home.homeDirectory}/.local/cache/ssh/authorized_keys ${config.home.homeDirectory}/.ssh/authorized_keys
      chmod 0600 ${config.home.homeDirectory}/.ssh/authorized_keys
    '';
  };
}
