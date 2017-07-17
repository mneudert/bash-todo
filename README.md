# Bash ToDo

_No bull, just todo notes_


## Usage

```shell
# display help
todo
todo help

# backup todos into (.tar.gz compressed) outfile
todo backup --export /path/to/outfile

# clear todos
todo clear

# clear todos recursively
todo clear --recursive

# print count of todos
todo count

# prints todos
todo list

# lists orphaned todos (respective directory missing)
# implicitly recursive below current working directory
todo list --orphaned

# lists orphaned todo filenames (not contents)
todo list --orphaned --raw

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

# change an existing entry
todo modify 4 this is the new message for todo 4

# swap two entries (only contents)
todo swap 5 2
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

__Note:__ If you are displaying the return code of the last executed command
in your prompt (like 'PR_STAT="$?"') be sure to grab that code __before__
getting the number of todos. Otherwise the return code displayed would be the
one from the `todo count` call.


## Completions

Available completion scripts are in the `completions` directory. Simple copy
or link the script matching your shell.


## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
