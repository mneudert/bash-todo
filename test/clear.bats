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


@test "clearing" {
  todo foo
  sleep 1
  todo bar

  run todo count

  [ "${status}" -eq 0 ]
  [ "${lines[0]}" = "2" ]

  todo clear
  run todo count

  [ "${status}" -eq 0 ]
  [ "${lines[0]}" = "0" ]
}

@test "recursive clearing" {
  todo foo
  mkdir subtest

  (
    cd subtest
    todo bar
  )

  run todo list --recursive --raw

  [ "${status}" -eq 0 ]
  [ "${#lines[@]}" = "2" ]

  todo clear --recursive
  run todo list --recursive --raw

  [ "${status}" -eq 0 ]
  [ "${#lines[@]}" = "0" ]
}
