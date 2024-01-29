# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# test -s ~/.alias && . ~/.alias || true

# Custom Aliases/Key Binds

# Custom Aliases/Key Binds

# Custom Bash Prompt
# Thanks to https://bash-prompt-generator.org/
PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'; PS1='[\[\e[38;5;200;1m\]\u\[\e[0m\]@\[\e[38;5;51;1m\]\h\[\e[0m\]:\w\[\e[38;5;46m\]${PS1_CMD1}\[\e[0m\]]\$ '
