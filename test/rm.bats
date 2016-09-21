#!/usr/bin/env bats

export PATH="$(dirname "${BATS_TEST_DIRNAME}"):${PATH}"

setup() {
  export TODO_ROOT=$(mktemp --directory --tmpdir bash-todo_XXXXXXXX)
  export TODO_BASE=$(mktemp --directory --tmpdir bash-todo_XXXXXXXX)

  cd $TODO_BASE
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
