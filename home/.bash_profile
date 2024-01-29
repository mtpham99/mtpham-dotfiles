# Bash Profile

# Source .bashrc
if [ -x "~/.bashrc" ] ; then
    . "~/.bashrc"
fi

# Custom Env Vars

# Editor
if [ -x "/usr/bin/nvim" ] ; then
    export EDITOR="/usr/bin/nvim"
    export SUDO_EDITOR="/usr/bin/nvim"
    export VISUAL="/usr/bin/nvim"
fi

# NVIDIA
# 1: Offload to GPU 0: Don't offload (use prime-run)
# DRI_PRIME=0
# __NV_PRIME_RENDER_OFFLOAD=0
# __GLX_VENDOR_LIBRARY_NAME=nvidia 
# GBM_BACKEND=nvidia-drm

# VA-API Decoding
# NVD_LOG=1
export NVD_GPU=0
export NVD_BACKEND=direct  # "direct" or "egl"
# LIBVA_DRIVER_NAME=nvidia
# LIBVA_DRIVER_NAME=iHD

# VDPAU Decoding
# VDPAU_DRIVER=nvidia

# Firefox Vaapi (run firefox w/ prime-run)
export MOZ_DISABLE_RDD_SANDBOX=1
# export __EGL_VENDOR_LIBRARY_FILENAMES="/usr/share/glvnd/egl_vendor.d/10_nvidia.json"

# Custom Env Vars
