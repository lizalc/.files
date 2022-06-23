export OS_NAME=$(uname)

if [[ $OS_NAME == "Linux" ]]; then
	eval $(luarocks path)

	export NPM_CONFIG_USERCONFIG="${HOME}/.config/npm/npmrc"
	export PATH="${PATH}:/usr/lib/llvm/14/bin:${HOME}/.local/bin:${HOME}/.local/npm/bin"

	export CARGO_HOME="${HOME}/.local/cargo"

	# Gentoo dotnet package does not install to the expected /usr/share/dotnet directory.
	# Set the root manually based on current dotnet executable location.
	export DOTNET_ROOT="$(dirname $(readlink -f $(which dotnet)))"

	export GOBIN="/home/liza/.local/bin"
	export GOCACHE="/home/liza/.cache/go/go-build"
	export GOENV="/home/liza/.config/go/env"
	export GOMODCACHE="/home/liza/.cache/go/pkg/mod"
	export GOPATH="/home/liza/.local/go"
elif [[ $OS_NAME == "Darwin" ]]; then
	# Enable color output for 'ls' and possibly other commands
	export CLICOLOR=1

	# Set neovim as EDITOR
	export EDITOR="nvim"

	export JAVA_HOME=$(/usr/libexec/java_home)

	# Add `diff-highlight` and local bins to the $PATH
	diffPath="/opt/homebrew/opt/git/share/git-core/contrib/diff-highlight"
    export PATH="/opt/homebrew/opt/python@3.10/bin:${PATH}:${diffPath}:/opt/homebrew/opt/llvm/bin:${HOME}/.gem/ruby/2.6.0/bin:${HOME}/.local/bin:${HOME}/go/bin"
fi
