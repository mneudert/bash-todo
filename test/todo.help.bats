#!/usr/bin/env bats

export PATH="$(dirname "${BATS_TEST_DIRNAME}"):${PATH}"


@test "no parameters displays help" {
  run todo

  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Usage: todo <command>" ]
}

@test "help command displays help" {
  run todo help

  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Usage: todo <command>" ]
}
