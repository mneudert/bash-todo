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


@test "raw listing" {
  run todo foo
  run sleep 1
  run todo bar
  run todo list --raw

  [ "${status}" -eq 0 ]
  [ "${#lines[@]}" = "2" ]
  [ "${lines[0]}" != "foo" ]
}


@test "recursive listing" {
  run todo foo

  mkdir subtest
  cd subtest

  run todo bar

  cd ..

  run todo list --recursive

  [ "${status}" -eq 0 ]
  [[ "${lines[1]}" == *"foo" ]]
  [[ "${lines[3]}" == *"bar" ]]
}


@test "recursive listing (raw)" {
  run todo foo

  mkdir subtest
  cd subtest

  run todo bar

  cd ..

  run todo list --recursive --raw

  [ "${status}" -eq 0 ]
  [ "${#lines[@]}" = "2" ]
}
