# Completion behaviour. Sourced after oh-my-zsh so these override its defaults.

# Arrow-key menu instead of just cycling through matches.
zstyle ':completion:*' menu select

# Case-insensitive, then partial-word, then substring matching. Typing `dow`
# completes to `Downloads`; `fbr` completes to `foo_bar_baz`.
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# Colour completion candidates the same way ls colours files.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Group matches under headings (`-- file --`, `-- command --`) and describe them.
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages'     format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings'     format '%F{red}-- no matches --%f'
zstyle ':completion:*' verbose true

# Cache slow completions (apt-style package lists, brew formulae).
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# Don't offer the current directory back to you in `cd ../<TAB>`.
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Complete process IDs from a live ps listing for kill/killall.
zstyle ':completion:*:*:kill:*:processes' \
  command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Never complete these -- they are never what you meant.
zstyle ':completion:*:*:*:*:hosts' ignored-patterns '*'
zstyle ':completion:*:functions' ignored-patterns '_*'

# --- inline suggestions from history (zsh-autosuggestions) ---------------
# Accept the greyed-out suggestion with the right arrow key.
if [[ -r "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
  # Don't try to suggest against a 10k-character paste.
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# --- key bindings --------------------------------------------------------
bindkey '^[[A' history-substring-search-up    2>/dev/null
bindkey '^[[B' history-substring-search-down  2>/dev/null
bindkey '^[[1;5C' forward-word                # ctrl + right
bindkey '^[[1;5D' backward-word               # ctrl + left
bindkey '^U' backward-kill-line               # match bash, not zsh's kill-whole-line
