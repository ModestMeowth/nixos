default:
  just --choose --justfile "{{ justfile() }}"

build: git-pull os-build

switch: git-pull os-switch

test: git-pull os-test

os-build: git-pull
  nh os build .

home-build: git-pull
  nh home build .

os-switch: git-pull
  nh os switch .

home-switch: git-pull
  nh home switch .

os-test: git-pull
  nh os test .

home-test: git-pull
  nh home test .

boot: git-pull
  nh os boot .

git-pull:
  - git stash
  git pull --rebase
  - git stash pop

build-cache: git-pull
  nh os build . --hostname pwnyboy
  nh os build . --hostname rocinante
  nh os build . --hostname videodrome
  nh home build . --configuration "mm@pwnyboy"
  nh home build . --configuration "mm@rocinante"
  nh home build . --configuration "mm@videodrome"
