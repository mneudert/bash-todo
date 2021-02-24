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


@test "swapping of existing todo" {
  todo first
  sleep 1
  todo second
  sleep 1
  todo third

  run todo list

  [ "$status" -eq 0 ]
  [ "${#lines[@]}" = "3" ]
  [[ "${lines[1]}" == *"second" ]]
  [[ "${lines[2]}" == *"third" ]]

  todo swap 2 3
  run todo list

  [ "$status" -eq 0 ]
  [ "${#lines[@]}" = "3" ]
  [[ "${lines[1]}" == *"third" ]]
  [[ "${lines[2]}" == *"second" ]]
}
