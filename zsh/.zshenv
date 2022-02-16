# Enable color output for 'ls' and possibly other commands
export CLICOLOR=1

# Set neovim as EDITOR
export EDITOR="nvim"

export JAVA_HOME=$(/usr/libexec/java_home)

# Add `diff-highlight` and local bins to the $PATH
diffPath="/opt/homebrew/opt/git/share/git-core/contrib/diff-highlight"
export PATH="/opt/homebrew/opt/python@3.10/bin:${PATH}:${diffPath}:${HOME}/.gem/ruby/2.6.0/bin:${HOME}/.local/bin"
