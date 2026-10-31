{den, lib, ...}:
let
  inherit (lib) mkOption types;

  settingsType =
    let
      inherit (den.lib.aspects.fx.keyClassification) isStructuralKey;
      classKeys = den.classes or { };
      quirkKeys = den.quirks or { };
      skipKey = k: isStructuralKey k || classKeys ? ${k} || quirkKeys ? ${k};

      reshapeSettings =
        raw:
          let
            imports' = raw.imports or [ ];
            config' = raw.config or { };
          in
          {
            imports = imports';
            config = config';
            options = removeAttrs raw [
              "imports"
              "config"
            ];
          };

      hasSettingsDeep =
        node:
          builtins.isAttrs node
          &&
          ((node ? settings)
            || lib.any
              (k: !(skipKey k) && hasSettingsDeep (node.${k} or null))
                (builtins.attrNames node));

      nodeModule =
        node:
          let
            ownSettings = if node ? settings then
              reshapeSettings node.settings
            else {
              imports = [ ];
              config =  { };
              options = { };
            };

            settingChildren = lib.filterAttrs
              (k: v: !(skipKey k) && builtins.isAttrs v && hasSettingsDeep v) node;

            childOptions = lib.mapAttrs
              (name: child:
                mkOption {
                  type = types.submodule (nodeModule child);
                  default = { };
                  description = "Settings under ${name}";
              }) settingChildren;

            ownImports = ownSettings.imports or [ ];
            ownConfig = ownSettings.config or { };
          in
          {
            imports = ownImports;
            config = ownConfig;
            options = (ownSettings.options or {}) // childOptions;
          };
    in
    types.submodule (nodeModule { });
in
{
  den = {
    reservedKeys = [ "settings" ];

    schema.conf = {
      imports = [
        {
          options.settings =
            mkOption {
              type = settingsType;
              default = { };
              description = "Per-aspect typed settings";
            }
            //
            {
              identity = false;
            };
        }
      ];
    };

    policies.settings-injection =
      {
        host ? null,
        home ? null,
        ...
      }:
      [
        (den.lib.policy.resolve {
          settings = if host ? settings then
            host.settings
          else if home ? settings then
            home.settings
          else
            throw "No settings found on host or home";
        })
      ];

    default.includes = [ den.policies.settings-injection ];
  };
}
