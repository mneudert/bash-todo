#!/usr/bin/env bats

PATH=$(dirname "${BATS_TEST_DIRNAME}"):${PATH}

export PATH

setup() {
  TODO_ROOT=$(mktemp -d -t bash-todo_XXXXXXXX)
  TODO_BASE=$(mktemp -d -t bash-todo_XXXXXXXX)

  cd "${TODO_BASE}" || exit

  export TODO_ROOT
  export TODO_BASE
}

teardown() {
  rm -rf "${TODO_ROOT}"
  rm -rf "${TODO_BASE}"
}


@test "removal of a single todo" {
  run todo first
  run sleep 1
  run todo second
  run sleep 1
  run todo third

  run todo list

  [ "$status" -eq 0 ]
  [ "${#lines[@]}" = "3" ]

  run todo rm 2
  run todo list

  [ "$status" -eq 0 ]
  [[ "${lines[0]}" == *"first" ]]
  [[ "${lines[1]}" == *"third" ]]
}
