export EDITOR='micro'
export VISUAL='micro'

# Editor used by CLI
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi

export NODE_OPTIONS=--max-old-space-size=4096

# Color man pages with bat
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

export PATH="$HOME/bin:~/.local/bin:$PATH"
# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/f1del/.lmstudio/bin"
# End of LM Studio CLI section
