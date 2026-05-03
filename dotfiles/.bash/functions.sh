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
# Create a new worktree and branch from within current git directory.
ga() {
  if [[ -z "$1" ]]; then
    echo "Usage: ga [branch name]"
    return 1
  fi

  local branch="$1"
  local base="$(basename "$PWD")"
  local wt_path="../${base}--${branch}"

  git worktree add -b "$branch" "$wt_path"
  mise trust "$wt_path"
  cd "$wt_path"
}

# Remove worktree and branch from within active worktree directory.
gd() {
  if gum confirm "Remove worktree and branch?"; then
    local cwd base branch root worktree

    cwd="$(pwd)"
    worktree="$(basename "$cwd")"

    # split on first `--`
    root="${worktree%%--*}"
    branch="${worktree#*--}"

    # Protect against accidentally nuking a non-worktree directory
    if [[ "$root" != "$worktree" ]]; then
      cd "../$root"
      git worktree remove "$cwd" --force || return 1
      git branch -D "$branch"
    fi
  fi
}
