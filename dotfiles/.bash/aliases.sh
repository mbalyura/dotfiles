# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# opens a file or URL in the users preferred application
unalias open 2>/dev/null
function open {
  xdg-open "$@" >/dev/null 2>&1 &
}

# ls
if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias ll='eza -alghF --group-directories-first --icons=auto'
  alias la='eza -A'
  alias l='eza -F'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

# Git
alias g='git'
alias gaa='git add .'
alias gc='git commit'
unalias gcm 2>/dev/null
function gcm {
  git commit -m "$*"
}
alias gcam='git commit --amend'
alias gcamn='git commit --amend --no-edit'
alias gpl='git pull'
alias gpr='git pull --rebase'
alias gps='git push'
alias gpsf='git push --force-with-lease'
alias gst='git status'
alias glg='git lg'
alias gl='git l'
alias gmg='git merge'

#misc
alias myip='curl ipinfo.io/ip && echo ""'
alias mountgdr='google-drive-ocamlfuse ~/mygoogledrive'
unalias cperm 2>/dev/null
function cperm {
  # apply default permissions (755 for directories, 644 for files) to all items in a directory
  local dir="${1:?Usage: cperm <directory>}"
  sudo find "$dir" -type d -exec chmod 755 {} +
  sudo find "$dir" -type f -exec chmod 644 {} +
}
alias mine='sudo chown $(id -un):$(id -gn) -R'
alias docker-compose='docker compose'
alias tru='docker-compose -f /home/f1del/Downloads/docker-transmission-openvpn/docker-compose.yml up -d && sleep 3 && firefox --new-tab http://localhost:9091/transmission/web/'
alias trd='docker-compose -f /home/f1del/Downloads/docker-transmission-openvpn/docker-compose.yml down'
alias bv='~/bin/bash-video.sh'
alias bat='batcat'
alias p='prs'
alias pc='prs c'

# fzf with preview
if command -v fzf &> /dev/null; then
  alias ff="fzf --preview 'batcat --style=numbers --color=always {}'"
  # open selected file in editor
  unalias eff 2>/dev/null
  function eff {
    local file
    file=$(ff) || return
    [[ -n $file ]] || return
    "$EDITOR" "$file"
  }
fi

if command -v zoxide &> /dev/null; then
  alias cd="zd"
  zd() {
    if (( $# == 0 )); then
      builtin cd ~ || return
    elif [[ -d $1 ]]; then
      builtin cd "$1" || return
    else
      if ! z "$@"; then
        echo "Error: Directory not found"
        return 1
      fi

      printf "\U000F17A9 "
      pwd
    fi
  }
fi

#npm
alias nr='npm run'
alias ni='npm install'
alias nrm='npm remove'
alias pn='pnpm'
alias dev='if [[ $(docker compose ls -q) != $(pwd | xargs basename) ]]; then echo "stopping old containers (if needed)..." && docker ps -q | xargs docker stop ; fi; nr start && nr wpack'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
