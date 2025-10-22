buildhost := "pwnyboy"
hostname := `hostname`

os_opts := if buildhost == hostname { "" } else { "--build-host " + buildhost }
hm_opts := if buildhost == hostname { "" } else { "--builders " + buildhost }

default:
  just --choose --justfile "{{ justfile() }}"

build: git-pull os-build home-build

switch: git-pull os-switch home-switch

test: git-pull os-test home-test

os-build: git-pull
  nh os build {{ os_opts }} .

home-build: git-pull
  nh home build {{ hm_opts }} .

os-switch: git-pull
  nh os switch {{ os_opts }} .

home-switch: git-pull
  nh home switch {{ hm_opts }} .

os-test: git-pull
  nh os test {{ os_opts }} .

home-test: git-pull
  nh home test {{ hm_opts }}

boot: git-pull
  nh os boot {{ os_opts }} .

git-pull:
  - git stash
  git pull --rebase
  - git stash pop
