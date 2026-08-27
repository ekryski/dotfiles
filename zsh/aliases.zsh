# Aliases.

# --- navigation ----------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'

# --- ls, via eza ---------------------------------------------------------
# Falls back to the builtin ls if eza isn't installed.
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias ll='eza -l --group-directories-first --git --time-style=long-iso'
  alias la='eza -la --group-directories-first --git --time-style=long-iso'
  alias lt='eza --tree --level=2 --group-directories-first'
else
  alias ls='ls -G'
  alias ll='ls -lh'
  alias la='ls -lah'
fi

# --- cat, via bat --------------------------------------------------------
if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
  alias catp='bat'                       # with a pager
  export BAT_THEME='ansi'
fi

# --- git -----------------------------------------------------------------
alias gs='git status --short --branch'
alias gc='git commit'
alias gcam='git commit -am'
alias gp='git pull --rebase'
alias gpu='git push'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gb='git branch'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# --- docker --------------------------------------------------------------
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias dl='docker ps -l -q'
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias dex='docker exec -it'
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'

# --- colima --------------------------------------------------------------
# Colima is the Docker daemon on this machine; there is no Docker Desktop.
alias cst='colima start'
alias csp='colima stop'
alias cs='colima status'

# --- ansible -------------------------------------------------------------
alias an='ansible'
alias ap='ansible-playbook'

# --- python / node -------------------------------------------------------
# Both come from version managers, so no python3/pip3 aliases are needed --
# `python` is whatever uv pinned, `node` is whatever mise resolved.
alias py='python'
alias venv='uv venv'
alias pnx='pnpm dlx'

# --- shell ---------------------------------------------------------------
alias src='exec zsh'                     # full restart, not a re-source
alias zshconfig='$EDITOR ~/.zshrc'
alias zshlocal='$EDITOR ~/.zshrc.local'
alias dotfiles='cd ~/Development/personal/dotfiles'
alias which='whence -v'                  # shows aliases and functions too

# --- macOS ---------------------------------------------------------------
# See http://support.apple.com/kb/ht5343
alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
# Strip the quarantine flag Gatekeeper puts on downloaded files.
alias unquarantine='xattr -dr com.apple.quarantine'

# --- misc ----------------------------------------------------------------
alias ip='curl -s https://ifconfig.me && echo'
alias localip="ipconfig getifaddr en0"
alias ports='lsof -iTCP -sTCP:LISTEN -n -P'
