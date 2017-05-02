#!/usr/bin/env bats

export PATH="$(dirname "${BATS_TEST_DIRNAME}"):${PATH}"

setup() {
  export TODO_ROOT=$(mktemp -d -t bash-todo_XXXXXXXX)
  export TODO_BASE=$(mktemp -d -t bash-todo_XXXXXXXX)

  cd $TODO_BASE
}

teardown() {
  rm -rf "${TODO_ROOT}"
  rm -rf "${TODO_BASE}"
}


@test "swapping of existing todo" {
  run todo first
  run sleep 1
  run todo second
  run sleep 1
  run todo third

  run todo list

  [ "$status" -eq 0 ]
  [ "${#lines[@]}" = "3" ]
  [[ "${lines[1]}" == *"second" ]]
  [[ "${lines[2]}" == *"third" ]]

  run todo swap 2 3
  run todo list

  [ "$status" -eq 0 ]
  [ "${#lines[@]}" = "3" ]
  [[ "${lines[1]}" == *"third" ]]
  [[ "${lines[2]}" == *"second" ]]
}
