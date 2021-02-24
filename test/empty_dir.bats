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
