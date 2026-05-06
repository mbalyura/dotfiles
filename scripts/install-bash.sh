#!/usr/bin/env bash
set -euo pipefail

# Install userland tools referenced from dotfiles/.bash.
# Core/system commands such as bash, cd, ls, sed, tar, ssh, grep, pgrep, pkill,
# chmod, and sudo are intentionally not managed here.

DRY_RUN=0
TOOLS=(
  bat                      # syntax-highlighted file previewer
  bash-completion          # shared Bash completion framework
  eza                      # modern replacement for ls
  fd                       # fast file finder used by fzf completion helpers
  ffmpeg                   # media conversion and inspection tools
  fzf                      # interactive fuzzy finder
  google-drive-ocamlfuse   # Google Drive mount helper
  gum                      # interactive prompts for shell scripts # https://github.com/charmbracelet/gum/releases
  imagemagick              # image conversion and manipulation tools
  lesspipe                 # richer less previews for archives and binary files
  libnotify                # desktop notification helper used by notify-send
  mediainfo                # media metadata viewer
  micro                    # terminal text editor
  mise                     # per-project tool version manager
  xdg-utils                # desktop integration helpers such as xdg-open
  zoxide                   # smarter cd command with directory ranking
)

# Print usage information for the script.
usage() {
  cat <<'EOF'
Usage: scripts/install-bash-tools.sh [--dry-run]

Installs optional helper tools referenced by the Bash config.

Options:
  --dry-run          Print what would be installed.
  -h, --help         Show this help.
EOF
}

while (($#)); do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

# Print a single line to stdout.
log() {
  printf '%s\n' "$*"
}

# Run a command normally or echo it in dry-run mode.
run() {
  if ((DRY_RUN)); then
    printf '[dry-run] %q' "$1"
    shift
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

# Check whether a command is available on PATH.
has() {
  command -v "$1" >/dev/null 2>&1
}

# Detect the supported package manager on this machine.
detect_manager() {
  if has apt-get; then
    echo apt
  elif has dnf; then
    echo dnf
  elif has pacman; then
    echo pacman
  else
    return 1
  fi
}

# Install one package with the active package manager.
install_package() {
  local manager=$1
  local package=$2

  log "Installing $package"
  case "$manager" in
    apt)
      run sudo apt-get install -y "$package"
      ;;
    dnf)
      run sudo dnf install -y "$package"
      ;;
    pacman)
      run sudo pacman -S --needed --noconfirm "$package"
      ;;
  esac
}

# Install a list of packages and report any failures without aborting early.
install_packages() {
  local manager=$1
  shift
  local package
  local installed=()
  local failed=()

  for package in "$@"; do
    if ! install_package "$manager" "$package"; then
      failed+=("$package")
      log "Could not install $package, continuing."
    else
      installed+=("$package")
    fi
  done

  if ((${#installed[@]})); then
    log ""
    if ((DRY_RUN)); then
      log "Packages that would be installed:"
    else
      log "Packages installed successfully:"
    fi
    printf '  - %s\n' "${installed[@]}"
  fi

  if ((${#failed[@]})); then
    log ""
    log "Packages that need a manual look:"
    printf '  - %s\n' "${failed[@]}"
  fi
}

# Map a conceptual tool name to the package name for the current manager.
package_for_tool() {
  local manager=$1
  local tool=$2

  case "$tool:$manager" in
    fd:apt|fd:dnf)
      echo fd-find
      ;;
    imagemagick:dnf)
      echo ImageMagick
      ;;
    libnotify:apt)
      echo libnotify-bin
      ;;
    google-drive-ocamlfuse:dnf|google-drive-ocamlfuse:pacman)
      return 1
      ;;
    *)
      echo "$tool"
      ;;
  esac
}

# Expand the shared tool list into manager-specific package names.
packages_for_manager() {
  local manager=$1
  local tool package

  for tool in "${TOOLS[@]}"; do
    if package=$(package_for_tool "$manager" "$tool"); then
      printf '%s\n' "$package"
    else
      log "Skipping $tool: no $manager package configured." >&2
    fi
  done
}

# Create a fd symlink when the distro ships it as fdfind.
ensure_fd_name() {
  if has fd || ! has fdfind; then
    return
  fi

  run mkdir -p "$HOME/.local/bin"
  run ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
  log "Linked fdfind to $HOME/.local/bin/fd for fzf completions."
}

# Drive the install flow from package-manager detection to setup.
main() {
  local manager
  local packages=()

  manager=$(detect_manager) || {
    echo "No supported package manager found. Expected apt-get, dnf, or pacman." >&2
    exit 1
  }

  log "Detected package manager: $manager"
  mapfile -t packages < <(packages_for_manager "$manager")

  case "$manager" in
    apt)
      run sudo apt-get update
      ;;
  esac

  install_packages "$manager" "${packages[@]}"

  ensure_fd_name

  log ""
  log "Done. Restart your shell, then run:"
  log "  fzf --version"
  log "  eza --version"
  log "  zoxide --version"
  log "  batcat --version || bat --version"
  log "  mise --version"
}

main "$@"
