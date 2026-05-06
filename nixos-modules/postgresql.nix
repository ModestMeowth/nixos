{config, lib, pkgs, ...}:
let
  cfg = config.services.postgresql;
  upgrade-script =
    old: new:
    let
      oldStr = builtins.toString old;
      newStr = builtins.toString new;

      oldPkg = pkgs.${"postgresql_${oldStr}"};
      newPkg = pkgs.${"postgresql_${newStr}"};
    in
    pkgs.writeScriptBin "upgrade-pg-cluster-${oldStr}-${newStr}" # bash
    ''
      set -eux
      # XXX it's perhaps advisable to stop all services that depend on postgresql
      systemctl stop postgresql

      export NEWDATA="/var/lib/postgresql/${newPkg.psqlSchema}"
      export NEWBIN="${newPkg}/bin"

      export OLDDATA="/var/lib/postgresql/${oldPkg.psqlSchema}"
      export OLDBIN="${oldPkg}/bin"

      install -d -m 0700 -o postgres -g postgres "$NEWDATA"
      cd "$NEWDATA"
      sudo -u postgres $NEWBIN/initdb -D "$NEWDATA"

      sudo -u postgres $NEWBIN/pg_upgrade \
        --old-datadir "$OLDDATA" --new-datadir "$NEWDATA" \
        --old-bindir $OLDBIN --new-bindr $NEWBIN \
        "$@"
    '';

  defaultAuth = ''
      #type database DBuser origin-address auth-method
      local all      all    peer
  '';

  authTCP = ''
      # ipv4
      host  all      all    127.0.0.1/32   password
      # ipv6
      host  all      all    ::1/128        password
  '';
in
{
  services.postgresql = {
    enable = true;
    authentication = lib.mkMerge [
      defaultAuth
      (lib.mkIf cfg.enableTCPIP authTCP)
    ];
  };

  environment.systemPackages = lib.mkIf cfg.enable [
    (upgrade-script 15 16)
    (upgrade-script 16 17)
  ];
}
