BUILD_HOST := "pwnyboy"

default:
  just --choose --justfile "{{ justfile() }}"

build: git-pull os-build home-build

switch: git-pull os-switch home-switch

test: git-pull os-test home-test

os-build: git-pull
  nh os build --build-host {{ BUILD_HOST }} .

home-build: git-pull
  nh home build --builders {{ BUILD_HOST }} .

os-switch: git-pull
  nh os switch --build-host {{ BUILD_HOST }} .

home-switch: git-pull
  nh home switch --builders {{ BUILD_HOST }} .

os-test: git-pull
  nh os test --build-host {{ BUILD_HOST }} .

home-test: git-pull
  nh home test --builders {{ BUILD_HOST }} .

boot: git-pull
  nh os boot --build-host {{ BUILD_HOST }} .

git-pull:
  - git stash
  git pull --rebase
  - git stash pop
