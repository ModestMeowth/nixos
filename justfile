buildhost := "pwnyboy"
hostname := `hostname`

os_opts := if buildhost == hostname { "" } else { "--build-host " + buildhost }
hm_opts := if buildhost == hostname { "" } else { "--builders " + buildhost }

default:
  just --choose --justfile "{{ justfile() }}"

build: pull os-build home-build

switch: pull os-switch home-switch

test: pull os-test home-test

os-build: pull
  nh os build {{ os_opts }} .

home-build: pull
  nh home build {{ hm_opts }} .

os-switch: pull
  nh os switch {{ os_opts }} .

home-switch: pull
  nh home switch {{ hm_opts }} .

os-test: pull
  nh os test {{ os_opts }} .

home-test: pull
  nh home test {{ hm_opts }}

boot: pull
  nh os boot {{ os_opts }} .

pull:
  - git stash
  git pull --rebase
  - git stash pop
