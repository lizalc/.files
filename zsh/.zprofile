if [[ $OS_NAME == "Linux" ]]; then
	brew_path="/home/linuxbrew/.linuxbrew/"
elif [[ $OS_NAME == "Darwin" ]]; then
	brew_path="/opt/homebrew/"
fi

eval "$(${brew_path}/bin/brew shellenv)"
