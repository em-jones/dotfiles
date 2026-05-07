set -x DOTNET_ROOT ~/dotnet
set -x theme_color_scheme nord
fish_add_path ~/dotnet
fish_add_path ~/.cargo/bin
if echo $ELS_MODE | grep -q 'debug_adapter'
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
fish_add_path ~/.bun/bin/

# opencode
fish_add_path /home/em/.opencode/bin

if test -f "$PWD/devbox.json"  
    eval (devbox shellenv --preserve-path-stack -c $PWD | string collect)
end


if not test -d $HOME/.rustup
    echo "Installing Rustup"
    mkdir -p $HOME/.rustup
    set -x RUSTUP_HOME $HOME/.rustup
    set -x CARGO_HOME $HOME/.cargo
    set -x PATH $CARGO_HOME/bin:$PATH
    set -x LIBRARY_PATH $LIBRARY_PATH:\"$HOME/.local/share/devbox/global/default/.devbox/nix/profile/default/lib\"
    rustup default stable
end

# Added by get-aspire-cli.sh
fish_add_path $HOME/.aspire/bin

# NemoClaw PATH setup
fish_add_path --path --append "/home/em/.local/bin"
fish_add_path --path --append "/home/em/.vite-plus/js_runtime/node/24.15.0/bin"
# end NemoClaw PATH setup

# OpenClaw Completion
source "/home/em/.openclaw/completions/openclaw.fish"
fish_add_path /opt/nvim/bin/
