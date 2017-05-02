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


@test "handling of directories with spaces" {
  mkdir "subtest with space"
  cd "subtest with space"

  todo working

  run todo count

  [ "${status}" -eq 0 ]
  [ "${lines[0]}" = "1" ]

  cd ..

  run todo list --recursive

  [ "${status}" -eq 0 ]
  [[ "${lines[0]}" == *"subtest with space"* ]]
  [[ "${lines[1]}" == *"working" ]]
}
