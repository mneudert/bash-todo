# Bash ToDo shell completion: bash

_todo()
{
  COMPREPLY=()

  local cmd=${COMP_WORDS[1]}
  local cur=${COMP_WORDS[COMP_CWORD]}
  local prev=${COMP_WORDS[COMP_CWORD-1]}

  local commands='backup clear count help list modify rm swap'

  # Complete on the first term (command)
  if [ $COMP_CWORD -eq 1 ]; then
    COMPREPLY=($(compgen -W "${commands}" -- ${cur}))
    return 0
  fi

  # Complete command flags
  case "${cmd}" in
    backup) COMPREPLY=($(compgen -W '--export' -- ${cur}));;
    clear)  COMPREPLY=($(compgen -W '--recursive' -- ${cur}));;
    list)   COMPREPLY=($(compgen -W '--orphaned --raw --recursive' -- ${cur}));;
  esac
}

complete -F _todo todo
