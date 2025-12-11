set -x DOTNET_ROOT ~/dotnet
fish_add_path ~/dotnet
fish_add_path ~/.cargo/bin
if echo $ELS_MODE | grep -q 'debug_adapter'
  set -x ELS_ELIXIR_OPTS "--name debugger@127.0.0.1 --cookie secret"
else
  devbox global shellenv --init-hook | source
end
set -x PODMAN_COMPOSE_PROVIDER podman-compose

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
