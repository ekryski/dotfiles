# .zprofile -- sourced once per login shell, before .zshrc.
#
# PATH and environment live here. Interactive niceties (prompt, completion,
# aliases) live in .zshrc.

# ---------------------------------------------------------------------------
# Homebrew
#
# /opt/homebrew on Apple Silicon, /usr/local on Intel. shellenv sets PATH,
# MANPATH, INFOPATH, HOMEBREW_PREFIX, HOMEBREW_CELLAR and HOMEBREW_REPOSITORY.
# ---------------------------------------------------------------------------
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Don't let `brew install` implicitly upgrade half the machine.
export HOMEBREW_NO_INSTALL_UPGRADE=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1

# ---------------------------------------------------------------------------
# PATH
#
# Built once, in explicit priority order -- earlier wins. typeset -U keeps the
# array de-duplicated, so re-sourcing this file is a no-op.
#
# Note: there is deliberately no "./bin" entry. The old config had one, which
# meant cd-ing into any repo put its bin/ ahead of /usr/bin -- a cloned repo
# could shadow `ls` or `git`. Use `./bin/foo` explicitly instead.
# ---------------------------------------------------------------------------
typeset -U path PATH

# Go modules install binaries here.
export GOPATH="${GOPATH:-$HOME/go}"

# pnpm's global bin directory.
export PNPM_HOME="$HOME/Library/pnpm"

path=(
  "$HOME/.local/bin"                          # uv tools and uv-managed pythons
  "$HOME/bin"                                 # personal scripts
  "$PNPM_HOME"
  "$GOPATH/bin"
  $path                                       # Homebrew, then the system
)

# Keg-only formulae are not symlinked into $HOMEBREW_PREFIX/bin, so their
# binaries have to be added by hand. These go *after* the user directories
# above but before the system, so /usr/bin/sqlite3 doesn't win.
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  path+=(
    "$HOMEBREW_PREFIX/opt/postgresql@18/bin"  # psql, pg_dump, createdb
    "$HOMEBREW_PREFIX/opt/sqlite/bin"         # newer than the system sqlite3
  )

  # LLVM is keg-only on purpose: putting it on PATH shadows Apple's clang and
  # breaks Xcode builds. Uncomment only if you specifically need it.
  # path+=("$HOMEBREW_PREFIX/opt/llvm/bin")
fi

export PATH

# nvm is installed as an escape hatch for projects that insist on it, but it is
# NOT loaded by default -- its shims fight with mise's. Uncomment to hand node
# management back to nvm (and drop `node` from ~/.config/mise/config.toml).
# export NVM_DIR="$HOME/.nvm"
# [[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]] && source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"

# ---------------------------------------------------------------------------
# Editor
# ---------------------------------------------------------------------------
if [[ -n "$SSH_CONNECTION" ]]; then
  export EDITOR="vim"
else
  export EDITOR="cursor --wait"
fi
export VISUAL="$EDITOR"
export PAGER="less"
export LESS="-R"

# ---------------------------------------------------------------------------
# Locale
# ---------------------------------------------------------------------------
export LANG="${LANG:-en_CA.UTF-8}"
export LC_ALL="${LC_ALL:-en_CA.UTF-8}"

# ---------------------------------------------------------------------------
# Machine-local environment
#
# Tokens, per-machine paths, work-only config. Never committed.
# ---------------------------------------------------------------------------
[[ -f "$HOME/.zprofile.local" ]] && source "$HOME/.zprofile.local"
