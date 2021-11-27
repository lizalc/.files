# Enable color output for 'ls' and possibly other commands
export CLICOLOR=1

# Set neovim as EDITOR
export EDITOR="nvim"

# Find `diff-highlight` and add it to the $PATH
gitVer="$(/opt/homebrew/bin/git --version | cut -f3 -d' ')"
diffPath="/opt/homebrew/Cellar/git/${gitVer}/share/git-core/contrib/diff-highlight"
export PATH=$PATH:$diffPath
