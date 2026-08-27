# Shell functions. Anything that needs arguments or logic lives here rather
# than being crammed into an alias.

# mkdir and cd into it in one step.
mkcd() {
  [[ -z "$1" ]] && { print -u2 "usage: mkcd <dir>"; return 1 }
  mkdir -p "$1" && cd "$1"
}

# Delete every local branch that has already been merged into the current one.
prune-branches() {
  git branch --merged \
    | grep -vE '^\*|^\s*(master|main|develop)$' \
    | xargs -n 1 git branch -d
}

# Fuzzy-checkout a branch. No argument opens the picker.
gcof() {
  local branch
  branch=$(git branch --all --format='%(refname:short)' \
    | sed 's|^origin/||' | sort -u | fzf --query="${1:-}" --select-1 --exit-0)
  [[ -n "$branch" ]] && git checkout "$branch"
}

# What is listening on a port?
port() {
  [[ -z "$1" ]] && { print -u2 "usage: port <number>"; return 1 }
  lsof -nP -iTCP:"$1" -sTCP:LISTEN
}

# Kill whatever is holding a port. Useful when a dev server won't die.
killport() {
  [[ -z "$1" ]] && { print -u2 "usage: killport <number>"; return 1 }
  local pids
  pids=$(lsof -ti tcp:"$1")
  [[ -z "$pids" ]] && { print "nothing listening on $1"; return 0 }
  print "killing: $pids"
  kill -9 ${=pids}
}

# Extract-and-cd is covered by the oh-my-zsh `extract` plugin; this is the
# inverse -- a dated tarball of a directory.
archive() {
  [[ -z "$1" ]] && { print -u2 "usage: archive <dir>"; return 1 }
  local name="${1:A:t}-$(date +%Y%m%d).tar.gz"
  tar -czf "$name" "$1" && print "created $name"
}

# Regenerate the cached tool completions (after upgrading mise, uv, op, ...).
zsh-refresh-completions() {
  rm -rf "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions" \
         "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"/.zcompdump*
  print "cleared; restarting shell"
  exec zsh
}

# How long does opening a shell actually take?
zsh-benchmark() {
  local runs="${1:-10}"
  time (for _ in {1..$runs}; do zsh -i -c exit; done)
}

# Route local traffic over ethernet on networks without a proxy.
route-add-local()    { sudo route add -net 10.0.0.0/8 -interface en0 }
route-delete-local() { sudo route delete 10.0.0.0 }
