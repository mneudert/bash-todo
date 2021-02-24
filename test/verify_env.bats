#!/usr/bin/env bats

PATH=$(dirname "${BATS_TEST_DIRNAME}"):${PATH}

export PATH

@test "exits if TODO_ROOT cannot be created" {
  TODO_ROOT='/root/.todo-test-error'

  export TODO_ROOT

  run todo

  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"${TODO_ROOT}" ]]
}
