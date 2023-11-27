#!/usr/bin/env bash

set -e

HERE="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export TF_LOG=DEBUG

declare -a bluePrints=(
  "getting-started/v4"
  "getting-started/v5"
)

test () {
  printf "\033[36mRunning Smoke Test for CloudBees CI Blueprint %s...\033[0m\n\n" "$1"
  export ROOT=$1 
  export TF_LOG_PATH="$HERE/$ROOT/terraform.log"
  cd "$HERE"/.. && make tfDeploy
  cd "$HERE"/.. && make validate
  cd "$HERE"/.. && make tfDestroy
}

for var in "${bluePrints[@]}"
do
  test "${var}"
done
