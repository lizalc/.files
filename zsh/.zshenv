export OS_NAME=$(uname -o)

user_local="${HOME}/.local"
user_bin="${user_local}/bin"
user_config="${HOME}/.config"
user_cache="${HOME}/.cache"

export DOTNET_ROOT="${user_local}/dotnet"

export GNUPGHOME="${user_config}/gnupg"

export GOCACHE="${user_cache}/go/go-build"
export GOENV="${user_config}/go/env"
export GOMODCACHE="${user_cache}/go/pkg/mod"
export GOPATH="${user_local}/go"
export GOBIN="${GOPATH}/bin"

export RUSTUP_HOME="${user_local}/rustup"
export CARGO_HOME="${user_local}/cargo"

export NPM_CONFIG_USERCONFIG="${user_config}/npm/npmrc"
export NPM_GLOBAL_BIN="${user_local}/npm/bin"

export PATH="${PATH}:${user_bin}:${GOBIN}:${NPM_GLOBAL_BIN}:${DOTNET_ROOT}:${DOTNET_ROOT}/tools"

source "${user_local}/cargo/env"
