#!/bin/bash

gacp_dir="$HOME/gacp"

function log() {
  echo "[gacp installer] $1."
}

function clone_repo() {
  git -C $HOME clone https://github.com/lamakq/gacp.git
}

function update_repo() {
  git -C $gacp_dir pull
}

function clone_or_update_repo() {
  if [[ ! -e $gacp_dir ]]; then
    log "Cloning GACP under $gacp_dir."
    clone_repo
    return
  fi
  log "Pulling GACP since it is already cloned under $gacp_dir."
  update_repo
}

function create_initials_json() {
  log "Creating initials.json unless it is already created."
  if [[ ! -e $gacp_dir/initials.json ]]; then
      echo "{}" > $gacp_dir/initials.json
  fi
}

function append_to_file() {
  if ! grep -q "$1" "$2"; then
    echo "$1" >> "$2"
  fi
}

function make_file_executable() {
  chmod u+x "$1"
}

function create_alias() {
  append_to_file "alias $1=$2" "$3"
  make_file_executable "$2"
}

function shell_config_file() {
  if [ -n "$ZSH_VERSION" ]; then
    echo "~/.zshrc"
  elif [ -n "$BASH_VERSION" ]; then
    echo "~/.bash_profile"
  else
    log "Unknown shell. Exiting."
    exit 1
  fi
}

function create_if_not_exists() {
  filename=$1
  if ! [ -f "$filename" ]; then
    touch "$filename"
    log "Created $filename."
  fi
}

function register_gacp_in_path() {
  create_if_not_exists $(shell_config_file)
  log "Registering gacp aliases in "$(shell_config_file)" unless they are already there."

  create_alias gac "$gacp_dir"/bin/gac.sh "$(shell_config_file)"
  create_alias gacp "$gacp_dir"/bin/gacp.sh "$(shell_config_file)"
  create_alias gacp-add-initial "$gacp_dir"/bin/gacp-add-initial.sh "$(shell_config_file)"
}

clone_or_update_repo
create_initials_json
register_gacp_in_path