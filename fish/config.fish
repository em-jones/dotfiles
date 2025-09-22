set -x DOTNET_ROOT ~/dotnet
fish_add_path ~/dotnet
devbox global shellenv --init-hook | source
