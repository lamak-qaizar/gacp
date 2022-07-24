#!/bin/bash

gacp_dir="$HOME/gacp"

function clone_gacp() {
  echo "Cloning GACP unless it is already cloned under $gacp_dir."
  if [[ ! -e $gacp_dir ]]; then
      git -C $HOME clone https://github.com/lamakq/gacp.git
  fi
}

function update_gacp() {
  echo "Pulling GACP unless it is already cloned under $gacp_dir."
  git -C $gacp_dir pull
}

function create_initials_json() {
  echo "Creating initials.json unless it is already created."
  if [[ ! -e $gacp_dir/initials.json ]]; then
      echo "{}" > $gacp_dir/initials.json
  fi
}

function source_bash_profile_in_zsh_for_newer_macos() {
  echo "source ~/.bash_profile" >> ~/.zshrc
}

function register_gacp_in_path() {
  echo "Registering gacp in \$PATH unless it already there. \$PATH=$PATH"
  if [[ $PATH != *"$gacp_dir/bin"* ]]; then
    echo "export PATH=$PATH:$gacp_dir/bin" >> ~/.bash_profile
    source ~/.bash_profile
    source_bash_profile_in_zsh_for_newer_macos
    echo "~/.bash_profile has been updated. $gacp_dir/bin has been registered in PATH. \$PATH=$PATH"
  fi
}

clone_gacp
update_gacp
create_initials_json
register_gacp_in_path