# Bash ToDo

_No bull, just todo notes_


## Usage

```shell
# display help
todo
todo help

# clear todos
todo clear

# clear todos recursively
todo clear --recursive

# print count of todos
todo count

# prints todos
todo list

# lists todo filenames (not contents)
todo list --raw

# prints todos recursively
todo list --recursive

# lists todo filenames recursively (not contents)
todo list --recursive --raw

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
