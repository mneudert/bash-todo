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


@test "clearing" {
  run todo foo
  run sleep 1
  run todo bar

  run todo count

  [ "${status}" -eq 0 ]
  [ "${lines[0]}" = "2" ]

  run todo clear
  run todo count

  [ "${status}" -eq 0 ]
  [ "${lines[0]}" = "0" ]
}

@test "recursive clearing" {
  run todo foo

  mkdir subtest
  cd subtest

  run todo bar

  cd ..

  run todo list --recursive --raw

  [ "${status}" -eq 0 ]
  [ "${#lines[@]}" = "2" ]

  run todo clear --recursive
  run todo list --recursive --raw

  [ "${status}" -eq 0 ]
  [ "${#lines[@]}" = "0" ]
}
