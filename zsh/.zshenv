export OS_NAME=$(uname -o)

user_local="${HOME}/.local"
user_bin="${user_local}/bin"
user_config="${HOME}/.config"
user_cache="${HOME}/.cache"

export GOBIN="${user_bin}"
export GOCACHE="${user_cache}/go/go-build"
export GOENV="${user_config}/go/env"
export GOMODCACHE="${user_cache}/go/pkg/mod"
export GOPATH="${user_local}/go"

export CARGO_HOME="${user_local}/cargo"

export NPM_CONFIG_USERCONFIG="${user_config}/npm/npmrc"

export PATH="${PATH}:${user_bin}:${user_local}/npm/bin"
