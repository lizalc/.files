# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if type brew &>/dev/null
then
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.local/oh-my-zsh"

# Set name of the theme to load
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	autoupdate
	colored-man-pages
	colorize
	command-not-found
	docker
	dotenv
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

source $ZSH/oh-my-zsh.sh

if [[ $OS_NAME == "Linux" ]]; then
	# This really shouldn't be needed but something is causing git to
	# not be able to tab complete custom subcommands. It works in some
	# environments but not others.
	# Pulled from: https://stackoverflow.com/questions/38725102/how-to-add-custom-git-command-to-zsh-completion
	zstyle ':completion:*:*:git:*' user-commands ${${(M)${(k)commands}:#git-*}/git-/}

	alias open="cmd.exe /c \"${1}\""
elif [[ $OS_NAME == "Darwin" ]]; then
	# iTerm2 Integration
	test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

	alias ls="gls --color=auto"

	# Alias 'sed' to GNU version
	alias sed='gsed'

	# Make python modern
	alias python="python3"
fi

# User configuration

# For zsh-completions
autoload -U compinit && compinit

# pipenv
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"

# Enhance tab completion (from https://wiki.gentoo.org/wiki/Zsh/Guide)
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# pipx completion
autoload -U bashcompinit && bashcompinit
eval "$(register-python-argcomplete pipx)"

# To customize prompt, run `p10k configure` or edit .p10k.zsh.
[[ ! -f ~/.files/powerlevel10k/.p10k.zsh ]] || source ~/.files/powerlevel10k/.p10k.zsh

zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# Completion cache (from https://wiki.gentoo.org/wiki/Zsh/Guide)
zstyle ':completion::complete:*' use-cache 1

# Alias 'vim' to neovim ('nvim')
alias vim="nvim"

# bin / obj cleanup shortcut
alias rmbin="rm -rvf **/bin"
alias rmobj="rm -rvf **/obj"
alias rmall="rm -rvf **/bin **/obj"
