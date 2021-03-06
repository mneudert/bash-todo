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


@test "orphaned listing" {
  orphan_dir="test-orphaned-listing"
  orphan_todo="should be listed"

  mkdir "${orphan_dir}"

  (
    cd "${orphan_dir}"
    todo "${orphan_todo}"
  )

  rm -rf "${orphan_dir}"

  run todo list --orphaned

  [ "${status}" -eq 0 ]
  [[ "${lines[0]}" == *"${orphan_dir}"* ]]
  [[ "${lines[1]}" == *"orphaned"*"${orphan_todo}"* ]]
}


@test "orphaned listing (raw)" {
  orphan_dir="test-raw-orphaned-listing"
  orphan_todo="should not be printed"

  mkdir "${orphan_dir}"

  (
    cd "${orphan_dir}"
    todo "${orphan_todo}"
  )

  rm -rf "${orphan_dir}"

  run todo list --orphaned --raw

  [ "${status}" -eq 0 ]
  [ "${#lines[@]}" = "1" ]
}


@test "raw listing" {
  todo foo
  sleep 1
  todo bar

  run todo list --raw

  [ "${status}" -eq 0 ]
  [ "${#lines[@]}" = "2" ]
  [ "${lines[0]}" != "foo" ]
}


@test "recursive listing" {
  todo foo
  mkdir subtest

  (
    cd subtest
    todo bar
  )

  run todo list --recursive

  [ "${status}" -eq 0 ]
  [[ "${lines[1]}" == *"foo" ]]
  [[ "${lines[3]}" == *"bar" ]]
}


@test "recursive listing (raw)" {
  todo foo
  mkdir subtest

  (
    cd subtest
    todo bar
  )

  run todo list --recursive --raw

  [ "${status}" -eq 0 ]
  [ "${#lines[@]}" = "2" ]
}
