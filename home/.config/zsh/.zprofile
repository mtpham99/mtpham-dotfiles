# Environment Variables

# XDG Dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_DATA_DIRS=/usr/local/share:/usr/share

export XDG_DESKTOP_DIR=$HOME/desktop
export XDG_DOCUMENTS_DIR=$HOME/documents
export XDG_DOWNLOAD_DIR=$HOME/downloads
export XDG_MUSIC_DIR=$HOME/music
export XDG_PICTURES_DIR=$HOME/pictures
export XDG_PUBLICSHARE_DIR=$HOME/public
export XDG_TEMPLATES_DIR=$HOME/templates
export XDG_VIDEOS_DIR=$HOME/videos

# PATH
export PATH=$HOME/.local/bin:$PATH

# Flatpaks
FLATPAK_DIRS=$XDG_DATA_HOME/flatpak/exports/share:/var/lib/flatpak/exports/share
export XDG_DATA_DIRS=$XDG_DATA_HOME/applications:$FLATPAK_DIRS:$XDG_DATA_DIRS

# Mozilla
export MOZ_ENABLE_WAYLAND=1
# export MOZ_DRM_DEVICE=/dev/dri/card1 # nvidia gpu
# export MOZ_DRM_DEVICE=/dev/dri/card0 # intel gpu
# export MOZ_DISABLE_RDD_SANDBOX=1 # required for nvdec

# Editor/Pager
export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim
export PAGER=nvimpager
export MANPAGER=nvimpager

# SSH Agent
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

# GNUPG Home
export GNUPGHOME=$XDG_DATA_HOME/gnupg

# Custom Local AUR REPO (aur-local-repo)
export AUR_REPO=aur-local-repo
export AUR_DBROOT=/var/cache/pacman/aur-local-repo
export AUR_DBEXT=db.tar.zst
export AUR_LOCAL_REPO_DB=$AUR_DBROOT/$AUR_REPO.$AUR_DBEXT
export AUR_LOCAL_REPO_ROOT=$AUR_DBROOT

# XDG Cleanup (XDG-Ninja)
# Cuda Cache
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv
# IPython
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
# Python history
export PYTHONSTARTUP="/etc/python/pythonrc.py"
# Jupyterlab
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter
# TEX
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
# NPM
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
# Electrum
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"

# Start Hyprland
# if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
#   exec Hyprland &
# fi
