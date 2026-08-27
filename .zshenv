# .zshenv -- sourced by every zsh instance, interactive or not.
#
# Keep this file small and side-effect free. Anything that prints output or
# assumes a terminal breaks scp, rsync and `ssh host command`.

# XDG base directories. A lot of modern tooling (mise, gh, ghostty) looks here.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Cargo installs binaries to ~/.cargo/bin and writes this env file itself.
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
