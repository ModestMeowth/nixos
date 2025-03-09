default:
  just --choose --justfile "{{justfile()}}"

build: git-pull
  nh os build .

switch: git-pull
  nh os switch .

git-pull:
  git pull
