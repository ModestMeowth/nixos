default:
  just --choose --justfile "{{justfile()}}"

build:
  nh os build .

switch:
  nh os switch .
