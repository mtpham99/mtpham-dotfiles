# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=$XDG_CONFIG_HOME/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# Highlight tab completions
zstyle ":completion:*" menu select

# The following lines were added by compinstall
zstyle :compinstall filename '/home/mpham/.config/zsh/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Fish-like syntax highlihghting and suggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Custom keybinds
bindkey -v '^?' backward-delete-char # backspace deletes
bindkey -v '^R' history-incremental-pattern-search-backward

# Custom aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
