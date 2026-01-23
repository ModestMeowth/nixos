buildhost := "pwnyboy"
hostname := `hostname`

builder_opts := if buildhost == hostname {""} else {"--builders 'ssh://mm@" + buildhost +"' --max-jobs 0"}

pull:
  - git stash
  git pull --rebase
  - git stash pop

stashClear:
  git stash clear

boot:
  nh os boot {{builder_opts}}.

build: buildHost buildHome

buildHost:
  nh os build {{builder_opts}} .

buildHome:
  nh home build {{builder_opts}} .

switch: switchHost switchHome

switchHost:
  nh os switch {{builder_opts}} .

switchHome:
  nh home switch {{builder_opts}} .

mkrpi-img:
  nom build {{builder_opts}} \
    .#nixosConfigurations.rpi.config.system.build.sdImage --system aarch64-linux
