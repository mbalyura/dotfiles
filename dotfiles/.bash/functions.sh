######################## Compression ########################
pack() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias unpack="tar -xzf"


######################## SSH Port Forwarding Functions ########################
fip() {
  (( $# < 2 )) && echo "Usage: fip <host> <port1> [port2] ..." && return 1
  local host="$1"
  shift
  for port in "$@"; do
    ssh -f -N -L "$port:localhost:$port" "$host" && echo "Forwarding localhost:$port -> $host:$port"
  done
}
dip() {
  (( $# == 0 )) && echo "Usage: dip <port1> [port2] ..." && return 1
  for port in "$@"; do
    pkill -f "ssh.*-L $port:localhost:$port" && echo "Stopped forwarding port $port" || echo "No forwarding on port $port"
  done
}
lip() {
  pgrep -af "ssh.*-L [0-9]+:localhost:[0-9]+" || echo "No active forwards"
}


######################## Transcoding ########################
# Use ImageMagick 7's `magick` when available, otherwise fall back to IM6's `convert`.
imconvert() {
  if command -v magick >/dev/null 2>&1; then
    magick "$@"
  elif command -v convert >/dev/null 2>&1; then
    convert "$@"
  else
    echo "ImageMagick not found: need magick or convert" >&2
    return 1
  fi
}

# Transcode a video to a good-balance 1080p that's great for sharing online
transcode-video-1080p() {
  ffmpeg -i "$1" -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy "${1%.*}-1080p.mp4"
}
# Transcode a video to a good-balance 4K that's great for sharing online
transcode-video-4K() {
  ffmpeg -i "$1" -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k "${1%.*}-optimized.mp4"
}
# Transcode any image to JPG image that's great for shrinking wallpapers
img2jpg() {
  img="$1"
  shift

  imconvert "$img" "$@" -quality 85 -strip "${img%.*}-converted.jpg"
}
# Transcode any image to WebP for smaller, web-friendly files
img2webp() {
  img="$1"
  shift

  imconvert "$img" "$@" -quality 85 -strip "${img%.*}-converted.webp"
}
# Transcode any image to a small JPG (max 1080px wide)
img2jpg-small() {
  img="$1"
  shift

  imconvert "$img" "$@" -resize 1080x\> -quality 85 -strip "${img%.*}-small.jpg"
}
# Transcode any image to a 4K JPG (max 2160px wide)
img2jpg-medium() {
  img="$1"
  shift

  imconvert "$img" "$@" -resize 2160x\> -quality 85 -strip "${img%.*}-medium.jpg"
}
# Transcode any image to a 6K JPG (max 3160px wide)
img2jpg-large() {
  img="$1"
  shift

  imconvert "$img" "$@" -resize 3160x\> -quality 85 -strip "${img%.*}-large.jpg"
}
# Transcode any image to compressed-but-lossless PNG
img2png() {
  img="$1"
  shift

  imconvert "$img" "$@" -strip -define png:compression-filter=5 \
    -define png:compression-level=9 \
    -define png:compression-strategy=1 \
    -define png:exclude-chunk=all \
    "${img%.*}-optimized.png"
}


######################## Worktrees ########################
# Create a worktree from an existing branch, or create branch+worktree if missing.
gwa() {
  if [[ -z "$1" ]]; then
    echo "Usage: gwa [branch name]"
    return 1
  fi

  local branch="$1"
  local base="$(basename "$PWD")"
  local branch_path="${branch//\//-}"
  local wt_path="../${base}--${branch_path}"
  local created_branch=0

  if git show-ref --verify --quiet "refs/heads/$branch"; then
    git worktree add "$wt_path" "$branch"
  else
    git worktree add -b "$branch" "$wt_path"
    created_branch=1
  fi
  if [[ $created_branch -eq 1 ]]; then
    touch "$wt_path/.gwa-created-branch"
  fi
  mise trust "$wt_path"
  cd "$wt_path"
}

# Remove active worktree; delete branch only if it was created by gwa().
gwd() {
  if gum confirm "Remove worktree (and delete branch if it was newly created)"; then
    local cwd branch common_dir main_repo delete_branch

    cwd="$(pwd)"
    branch="$(git symbolic-ref --quiet --short HEAD)" || return 1
    common_dir="$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null || git rev-parse --git-common-dir)" || return 1
    main_repo="${common_dir%/.git}"
    delete_branch=0

    if [[ -f "$cwd/.gwa-created-branch" ]]; then
      delete_branch=1
    fi

    cd "$main_repo" || return 1
    git worktree remove "$cwd" --force || return 1

    if [[ $delete_branch -eq 1 ]]; then
      git branch -D "$branch"
    fi
  fi
}
