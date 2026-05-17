export EDITOR='micro'
export VISUAL='micro'

# Editor used by CLI
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi

export NODE_OPTIONS=--max-old-space-size=4096

# Color man pages with bat
export MANROFFOPT="-c"
if command -v bat >/dev/null 2>&1; then
  export MAN_BAT_CMD='bat'
else
  export MAN_BAT_CMD='batcat'
fi
export MANPAGER="sh -c 'col -bx | ${MAN_BAT_CMD} -l man -p'"

export PATH="/usr/local/bin:$HOME/bin:$HOME/.local/bin:$PATH"

# n node version manager
export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/f1del/.lmstudio/bin"
# End of LM Studio CLI section
