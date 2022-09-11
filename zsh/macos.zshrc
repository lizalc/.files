eval "$(/opt/homebrew/bin/brew shellenv)"

# Set LS_COLORS
eval "$(gdircolors)"

# For oh-my-zsh completion
export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Enable color output for 'ls' and possibly other commands
export CLICOLOR=1

# Set neovim as EDITOR
export EDITOR="nvim"

export JAVA_HOME=$(/usr/libexec/java_home)

# Add `diff-highlight` to $PATH
diffPath="/opt/homebrew/opt/git/share/git-core/contrib/diff-highlight"
export PATH="/opt/homebrew/opt/python@3.10/bin:${PATH}:${diffPath}:/opt/homebrew/opt/llvm/bin:${HOME}/.gem/ruby/2.6.0/bin"

# iTerm2 Integration
source "${HOME}/.iterm2_shell_integration.zsh"

alias ls="gls --color=auto"
# Alias 'sed' to GNU version
alias sed='gsed'
# Make plain python command available
alias python="python3"
