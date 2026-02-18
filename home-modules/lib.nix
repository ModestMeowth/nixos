{ lib, ... }:
let
  inherit (builtins)
    attrNames
    readDir
    readFile
    ;

  inherit (lib)
    mergeAttrsList
    ;

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

  mergeDotfiles =
    path:
    map (f: readFile f) (map (f: ../dotfiles/${path}/${f}) (attrNames (readDir ../dotfiles/${path})));

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
in
{
  mkBinFile = mkBinFile;
  mkBinFiles = mkBinFiles;
  mergeDotfiles = mergeDotfiles;
  mkFile = mkFile;
  mkFiles = mkFiles;
}
