# Completion search path. Sourced BEFORE oh-my-zsh, because oh-my-zsh runs
# compinit and only picks up what is on fpath at that moment.

# Homebrew's site-functions: zsh-completions plus whatever each formula ships
# (gh, docker, kubectl, helm, ...).
if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]]; then
  fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
fi

# Somewhere to cache completions for tools that generate them at runtime.
ZSH_COMPLETIONS_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"
mkdir -p "$ZSH_COMPLETIONS_DIR"
fpath=("$ZSH_COMPLETIONS_DIR" $fpath)

# Generate a completion file once and reuse it, rather than paying for an eval
# on every shell start. Delete ~/.cache/zsh/completions to regenerate after an
# upgrade (or run `zsh-refresh-completions`, defined in functions.zsh).
_dotfiles_gen_completion() {
  local name="$1"; shift
  local target="$ZSH_COMPLETIONS_DIR/_$name"
  [[ -s "$target" ]] && return 0
  command -v "$1" >/dev/null 2>&1 || return 0
  "$@" >"$target" 2>/dev/null || rm -f "$target"
}

_dotfiles_gen_completion mise mise completion zsh
_dotfiles_gen_completion uv   uv generate-shell-completion zsh
_dotfiles_gen_completion uvx  uvx --generate-shell-completion zsh
_dotfiles_gen_completion op   op completion zsh
_dotfiles_gen_completion colima colima completion zsh

typeset -U fpath
