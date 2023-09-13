#!/bin/bash

gacp_dir="$HOME/gacp"

function log() {
  echo "[gacp installer] $1"
}

function clone_or_update_repo() {
  if [[ ! -e $gacp_dir ]]; then
    log "Cloning GACP under $gacp_dir."
    git -C $HOME clone https://github.com/lamakq/gacp.git
  else
    log "Pulling GACP since it is already cloned under $gacp_dir."
    git -C $gacp_dir pull
  fi
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
  if [ "$SHELL" = "/bin/zsh" ]; then
    echo ~/.zshrc
  elif [ "$SHELL" = "/bin/bash" ]; then
    echo ~/.bash_profile
  else
    log "Unknown shell. Exiting."
    exit 1
  fi
}

function create_if_not_exists() {
  filename=$1
  if ! [ -f "$filename" ]; then
    touch $filename
    log "Created $filename."
  fi
}

function register_gacp_in_path() {
  log "Detected shell: $(shell_config_file)"
  create_if_not_exists $(shell_config_file)
  log "Registering gacp aliases in "$(shell_config_file)" unless they are already there."

  create_alias gac "$gacp_dir"/bin/gac.sh "$(shell_config_file)"
  create_alias gacp "$gacp_dir"/bin/gacp.sh "$(shell_config_file)"
  create_alias gacp-add-initial "$gacp_dir"/bin/gacp-add-initial.sh "$(shell_config_file)"
}

clone_or_update_repo
create_initials_json
register_gacp_in_path