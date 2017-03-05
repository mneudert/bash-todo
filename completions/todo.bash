# Bash ToDo shell completion: bash

_todo()
{
  COMPREPLY=()

  local cur=${COMP_WORDS[COMP_CWORD]}
  local prev=${COMP_WORDS[COMP_CWORD-1]}

  local commands='backup clear count list modify rm swap'

  # Complete on the first term (command)
  if [ $COMP_CWORD -eq 1 ]; then
    COMPREPLY=($(compgen -W "${commands}" -- ${cur}))
    return 0
  fi
}

complete -F _todo todo
