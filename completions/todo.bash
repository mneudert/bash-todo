# Bash ToDo shell completion: bash

_todo()
{
  COMPREPLY=()

  cur=${COMP_WORDS[COMP_CWORD]}
  prev=${COMP_WORDS[COMP_CWORD-1]}

  # Complete all commands
  opts='backup clear count list modify rm swap'

  # Only complete on the first term
  if [ $COMP_CWORD -eq 1 ]; then
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
  fi

}
complete -F _todo todo
