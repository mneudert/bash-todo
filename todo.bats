#!/usr/bin/env bats

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
