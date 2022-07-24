#!/bin/bash

gacp_dir="$HOME/gacp"

function clone_gacp() {
  if [[ ! -e $gacp_dir ]]; then
      git -C $HOME clone https://github.com/lamakq/gacp.git
  fi
}

function update_gacp() {
  git -C $gacp_dir pull
}

function create_initials_json() {
  if [[ ! -e $gacp_dir/initials.json ]]; then
      echo "{}" > $gacp_dir/initials.json
  fi
}

function create_bash_profile() {
  if [[ ! -e ~/.bash_profile ]]; then
      touch ~/.bash_profile
  fi
}

function register_gacp_in_path() {
  if [[ $PATH != *"$gacp_dir/bin"* ]]; then
    export PATH=$PATH:$gacp_dir/bin
  fi
}

clone_gacp
update_gacp
create_initials_json
register_gacp_in_path