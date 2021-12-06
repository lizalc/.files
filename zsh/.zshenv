# Enable color output for 'ls' and possibly other commands
export CLICOLOR=1

# Set neovim as EDITOR
export EDITOR="nvim"

# Add `diff-highlight` to the $PATH
diffPath="/opt/homebrew/opt/git/share/git-core/contrib/diff-highlight/"
export PATH=$PATH:$diffPath
