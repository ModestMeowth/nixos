{
  buildGoModule,
  callPackage,
  installShellFiles,
  lib,
  nix-update-script,
  versionCheckHook,
  writableTmpDirAsHomeHook,
}:
let
  sourceData = callPackage ./_sources/generated.nix { };
in
buildGoModule (finalAttr: {
  inherit (sourceData.bootdev-cli)
    pname
    src
    version
    vendorHash
    ;

  ldflags = [
    "-s"
    "-w"
  ];

  nativeBuildInputs = [
    installShellFiles
    writableTmpDirAsHomeHook
  ];

  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgram = "${placeholder "out"}/bin/bootdev";
  doInstallCheck = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "CLI used to complete coding challenges and lessons on Boot.dev";
    homepage = "https://github.com/bootdotdev/bootdev";
    changelog = "https://github.com/bootdotdev/bootdev/releases/tag/${finalAttr.version}";
    license = lib.licenses.mit;
    mainProgram = "bootdev";
  };
})
