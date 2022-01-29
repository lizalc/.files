# Enable color output for 'ls' and possibly other commands
export CLICOLOR=1

# Set neovim as EDITOR
export EDITOR="nvim"

# Add `diff-highlight` and local bins to the $PATH
diffPath="/opt/homebrew/opt/git/share/git-core/contrib/diff-highlight"
export PATH="${PATH}:${diffPath}:${HOME}/.gem/ruby/2.6.0/bin:${HOME}/.local/bin"
