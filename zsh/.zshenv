export OS_NAME=$(uname)

if [[ $OS_NAME == "Linux" ]]; then
	eval $(luarocks path)

	export NPM_CONFIG_USERCONFIG="${HOME}/.config/npm/npmrc"
	export PATH="${HOME}/.local/bin:${HOME}/.local/npm/bin:${PATH}:/home/liza/.cargo/bin"
elif [[ $OS_NAME == "Darwin" ]]; then
	# Enable color output for 'ls' and possibly other commands
	export CLICOLOR=1

	# Set neovim as EDITOR
	export EDITOR="nvim"

	export JAVA_HOME=$(/usr/libexec/java_home)

	# Add `diff-highlight` and local bins to the $PATH
	diffPath="/opt/homebrew/opt/git/share/git-core/contrib/diff-highlight"
	export PATH="/opt/homebrew/opt/python@3.10/bin:${PATH}:${diffPath}:/opt/homebrew/opt/llvm/bin:${HOME}/.gem/ruby/2.6.0/bin:${HOME}/.local/bin"
fi
