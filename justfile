BUILD_HOST := "pwnyboy"
OPTS := "--builders " + BUILD_HOST

default:
  just --choose --justfile "{{ justfile() }}"

build: git-pull os-build home-build

switch: git-pull os-switch home-switch

test: git-pull os-test home-test

os-build: git-pull
  nh os build {{ OPTS }} .

home-build: git-pull
  nh home build {{ OPTS }} .

os-switch: git-pull
  nh os switch {{ OPTS }} .

home-switch: git-pull
  nh home switch {{ OPTS }} .

os-test: git-pull
  nh os test {{ OPTS }} .

home-test: git-pull
  nh home test {{ OPTS }} .

boot: git-pull
  nh os boot {{ OPTS }} .

git-pull:
  - git stash
  git pull --rebase
  - git stash pop
