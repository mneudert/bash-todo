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


@test "backup --export ../relative" {
  todo foo
  mkdir subdir

  (
    cd subdir
    todo bar
  )

  run todo backup --export "test_export.tar.gz"

  [ "${status}" -eq 0 ]
  [ -f "test_export.tar.gz" ]

  raw=$(basename "$(todo list --raw | head -1)")
  contents=$(tar -tvf "test_export.tar.gz")

  [[ "${contents}" == *"${raw}"* ]]
}

@test "backup --export /absolute" {
  todo foo
  mkdir subdir

  (
    cd subdir
    run todo bar
  )

  run todo backup --export "$(pwd)/test_export.tar.gz"

  [ "${status}" -eq 0 ]
  [ -f "test_export.tar.gz" ]

  raw=$(basename "$(todo list --raw | head -1)")
  contents=$(tar -tvf "test_export.tar.gz")

  [[ "${contents}" == *"${raw}"* ]]
}
