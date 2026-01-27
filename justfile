hostname := `hostname`
targethost := env("TARGETHOST", hostname)
buildhost := env("BUILDHOST", hostname)
builduser := env("BUILDUSER", env("USER"))

builder_opts := if buildhost == hostname {""} else {" --builders "+ builduser + "@" + buildhost + " --max-jobs 0"}
target_os_opts := if targethost == hostname {""} else {" -H " + targethost}
target_hm_opts := if targethost == hostname {""} else {" -c " + builduser + "@" + buildhost}

default:
  just --choose --justfile "{{justfile()}}"

pull:
  - git stash
  git pull --rebase
  - git stash pop

stashClear:
  git stash clear

boot:
  nh os boot{{builder_opts}}{{target_os_opts}} .

build: buildHost buildHome

buildHost:
  nh os build{{builder_opts}}{{target_os_opts}} .

buildHome:
  nh home build{{builder_opts}}{{target_hm_opts}} .

switch: switchHost switchHome

switchHost:
  nh os switch{{builder_opts}}{{target_os_opts}} .

switchHome:
  nh home switch{{builder_opts}}{{target_hm_opts}} .

mkrpi-img:
  nom build {{builder_opts}} \
    --out-link $HOME/rpi-sdcard \
    .#nixosConfigurations.rpi.config.system.build.sdImage --system aarch64-linux
