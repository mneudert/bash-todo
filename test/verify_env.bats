#!/usr/bin/env bats

export PATH="$(dirname "${BATS_TEST_DIRNAME}"):${PATH}"

@test "exits if TODO_ROOT cannot be created" {
  export TODO_ROOT="/root/.todo-test-error"

  run todo

  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"${TODO_ROOT}" ]]
}
