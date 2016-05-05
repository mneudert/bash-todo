# Bash ToDo

_No bull, just todo notes_


## Usage

```shell
# display help
todo
todo help

# clear todos
todo clear

# print count of todos
todo count

# list todos
todo list

# list todos without additional information (useful for sorting/processing)
todo list --raw

# lists todo files recursively without sort-/cat-ing
todo list --recursive

# delete single todo
todo rm [0-9]*

# create a new todo
todo some text where the first 2 parameters to not match any other command
```


## Shell Prompt Integration

### ZSH

Requires "precmd" to be available.

```zsh
precmd() {
    PR_TODOS=''
    PR_TODO_COUNT=$(todo count)

    if [[ 0 -lt "${PR_TODO_COUNT}" ]]; then
        PR_TODOS="(${PR_TODO_COUNT})"
    fi
}

PROMPT='[%n@%m:%c]${PR_TODOS}%# '
```
