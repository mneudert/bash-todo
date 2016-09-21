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


@test "empty directory counts zero" {
  run todo count

  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "0" ]
}

@test "empty directory displays empty list" {
  run todo list

  [ "$status" -eq 0 ]
  [ "${#lines[@]}" = "0" ]
}
