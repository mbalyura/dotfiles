# https://mise.jdx.dev/
# run a command with a specific version of a tool
# mise exec node@26 -- node -v
if command -v mise &> /dev/null; then
  eval "$(mise activate bash)"
fi

# zoxide is a smarter cd command, inspired by z and autojump.
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
fi
