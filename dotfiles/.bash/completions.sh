# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# fzf fuzzy finder.
# Install: apt install fzf, pacman -S fzf, brew install fzf, or git clone to ~/.fzf.
# Use: Ctrl-R history, Ctrl-T files, Alt-C directories,
# fuzzy completion with **<Tab> (kill **<Tab>, ssh **<Tab>, etc, vim **<Tab>, etc).
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'

  if command -v fd >/dev/null 2>&1; then
    export FZF_CTRL_T_OPTS="--preview='bat --color=always {}'"
    export FZF_ALT_C_OPTS="--preview='ls {}'"
    export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi

  for fzf_completion in \
    /usr/share/bash-completion/completions/fzf \
    /usr/share/fzf/completion.bash \
    /usr/share/doc/fzf/examples/completion.bash \
    /usr/local/share/fzf/completion.bash \
    /opt/homebrew/opt/fzf/shell/completion.bash \
    /home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.bash \
    "$HOME/.fzf/shell/completion.bash"
  do
    if [ -f "$fzf_completion" ]; then
      . "$fzf_completion"
      break
    fi
  done
  unset fzf_completion

  for fzf_key_bindings in \
    /usr/share/fzf/key-bindings.bash \
    /usr/share/doc/fzf/examples/key-bindings.bash \
    /usr/local/share/fzf/key-bindings.bash \
    /opt/homebrew/opt/fzf/shell/key-bindings.bash \
    /home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.bash \
    "$HOME/.fzf/shell/key-bindings.bash"
  do
    if [ -f "$fzf_key_bindings" ]; then
      . "$fzf_key_bindings"
      break
    fi
  done
  unset fzf_key_bindings
fi

# Load completions registered by Node/npm packages via tabtab.
# https://github.com/mklabs/tabtab
# uninstall by removing these lines
[ -f ~/.config/tabtab/bash/__tabtab.bash ] && . ~/.config/tabtab/bash/__tabtab.bash || true


### ANGULAR CLI
if command -v node >/dev/null 2>&1 && command -v ng >/dev/null 2>&1; then
  node_version=$(node -v)
  node_version=${node_version:1} # Remove 'v' at the beginning
  node_version=${node_version%\.*} # Remove trailing ".*".
  node_version=${node_version%\.*} # Remove trailing ".*".
  node_version=$(($node_version)) # Convert the NodeJS version number from a string to an integer.
  if [ "$node_version" -ge 16 ]; then
    # Load Angular CLI autocompletion.
    source <(ng completion script)
  fi
fi
