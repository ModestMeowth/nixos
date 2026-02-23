{ lib, ... }:
let
  inherit (lib)
    mergeAttrsList
    ;
in
rec {
  mkBinFile =
    binDir:
    {
      source,
      target ? source,
    }:
    {
      "${binDir}/${target}" = {
        source = ../dotfiles/bin/${source};
        executable = true;
      };
    };

  mkBinFiles = binDir: list: mergeAttrsList (map (f: (mkBinFile binDir { source = f; })) list);

  mkFile =
    {
      source,
      target ? source,
    }:
    {
      "${target}" = {
        source = ../dotfiles/${source};
        recursive = true;
      };
    };

  mkFiles = list: mergeAttrsList (map (f: mkFile { source = f; }) list);
}
