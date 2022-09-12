# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit .p10k.zsh.
[[ ! -f ~/.files/powerlevel10k/.p10k.zsh ]] || source ~/.files/powerlevel10k/.p10k.zsh

# This sets up Homebrew/etc so should be sourced before doing anything else.
if [[ $OS_NAME == "Darwin" ]]; then
	source ${HOME}/.files/zsh/macos.zshrc
fi

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.local/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	autoupdate
	colored-man-pages
	colorize
	command-not-found
	docker
	dotnet
	gem
	git
	gitignore
	golang
	fzf
	npm
	pip
	pipenv
	zsh-autosuggestions
	zsh-completions
	zsh-syntax-highlighting
)
# Source before modifying ZSH completions as oh-my-zsh sets it up.
source $ZSH/oh-my-zsh.sh

# This really shouldn't be needed but something is causing git to
# not be able to tab complete custom subcommands. It works in some
# environments but not others.
# Pulled from: https://stackoverflow.com/questions/38725102/how-to-add-custom-git-command-to-zsh-completion
# zstyle ':completion:*:*:git:*' user-commands ${${(M)${(k)commands}:#git-*}/git-/}

# From https://wiki.gentoo.org/wiki/Zsh/Guide
# Enhance tab completion
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
# Completion cache (from https://wiki.gentoo.org/wiki/Zsh/Guide)
zstyle ':completion::complete:*' use-cache 1

# Use LS_COLORS in tab completion output
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# pipx completion
if (( $+commands[pipx] )); then
	autoload -Uz bashcompinit && bashcompinit
	eval "$(register-python-argcomplete pipx)"
fi

# pipenv completion
if (( $+commands[pipenv] )); then
	eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"
fi

# luarocks setup
if (( $+commands[luarocks] )); then
	eval "$(luarocks path)"
fi

# direnv setup
if (( $+commands[direnv] )); then
	eval "$(direnv hook zsh)"
fi

# Gentoo dotnet package does not install to the expected /usr/share/dotnet directory.
# Set the root manually based on current dotnet executable location.
# export DOTNET_ROOT="$(dirname $(readlink -f $(which dotnet)))"

# Alias 'vim' to neovim ('nvim')
alias vim="nvim"

# bin / obj cleanup shortcut
alias rmbin="rm -rvf **/bin"
alias rmobj="rm -rvf **/obj"
alias rmall="rm -rvf **/bin **/obj"
