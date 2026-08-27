# Third-party tool initialisation.

# --- mise: node, ruby, go ------------------------------------------------
# `activate` hooks into precmd and rewrites PATH on cd, so per-project versions
# work without shims. Global defaults live in ~/.config/mise/config.toml.
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# --- uv: python ----------------------------------------------------------
# uv needs no shell hook. Interpreters land in ~/.local/share/uv/python and
# `uv tool install` puts CLIs on PATH via ~/.local/bin (already in .zprofile).
export UV_PYTHON_PREFERENCE="managed"

# --- zoxide: smarter cd --------------------------------------------------
# `z foo` jumps to the most-used directory matching foo. `cd` still works.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# --- fzf: fuzzy finding --------------------------------------------------
# Provides ctrl-r (history), ctrl-t (files) and alt-c (cd).
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)

  # Use fd so results respect .gitignore and skip .git.
  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi

  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline'
fi

# --- git-delta: better diffs ---------------------------------------------
# Wired up in .gitconfig; this just makes it the pager for `git` outside of it.
if command -v delta >/dev/null 2>&1; then
  export DELTA_FEATURES='+side-by-side'
fi

# --- gpg -----------------------------------------------------------------
# Needed for signed commits from a terminal, otherwise pinentry has no TTY.
export GPG_TTY=$(tty)

# --- google cloud sdk ----------------------------------------------------
# Only present if the gcloud cask is installed.
_gcloud_sdk="$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
if [[ -d "$_gcloud_sdk" ]]; then
  source "$_gcloud_sdk/path.zsh.inc"
  source "$_gcloud_sdk/completion.zsh.inc"
fi
unset _gcloud_sdk
