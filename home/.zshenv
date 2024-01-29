# ZSH Theme
if [ -z "${DISPLAY}" ] && [ "$XDG_VTNR" = 1 ]; then
    [[ ! -f $XDG_CONFIG_HOME/zsh/.p10k-tty.zsh ]] || source $XDG_CONFIG_HOME/zsh/.p10k-tty.zsh 
else
    [[ ! -f $XDG_CONFIG_HOME/zsh/.p10k.zsh ]] || source $XDG_CONFIG_HOME/zsh/.p10k.zsh 
fi

# Powerlevel10k Theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Pinentry TTY
export GPG_TTY=$(tty)

# Zsh config directory
ZDOTDIR=$XDG_CONFIG_HOME/zsh # DONT "export" this since ~/.zshenv wont be read if this is defined (e.g. "/home/foo/.zshenv" wouldn't be sourced when using "su foo")
