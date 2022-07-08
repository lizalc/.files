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

	# Oh My Zsh sets LSCOLORS which can override the iTerm2 theme. This impacts 'ls'
	# only, but it's annoying since it changes the theme. Unset LSCOLORS here to
	# workaround and use the default theme colors.
	unset LSCOLORS

	# Futher macOS 'ls' fun: Separate colors for broken symlinks is not possible.
	# To workaround this the GNU 'ls' is used (via 'gls', installed from homebrew).
	# This sets the LS_COLORS appropriately from the 'gdircolors' which has been
	# modified to un-bold the directories, aliases 'ls' to 'gls --color=auto', and
	# adds the LS_COLORS to the zsh completion colors.
	export LS_COLORS='rs=0:di=34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
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
