# .zshrc -- sourced for interactive shells only.
#
# Load order matters:
#   1. zsh/fpath.zsh    -- must run BEFORE oh-my-zsh, which calls compinit
#   2. oh-my-zsh        -- sets its own completion styles and key bindings
#   3. zsh/*.zsh        -- our config, loaded after so it wins
#   4. ~/.zshrc.local   -- machine-local secrets and overrides, always last

ZSH_CONFIG_DIR="${ZSH_CONFIG_DIR:-$HOME/.zsh}"

# ---------------------------------------------------------------------------
# Completion search path
#
# oh-my-zsh runs compinit, so anything that needs to be on fpath has to be
# there first. That includes Homebrew's site-functions (zsh-completions, gh,
# docker, ...) and the completions we generate for mise/uv.
# ---------------------------------------------------------------------------
[[ -r "$ZSH_CONFIG_DIR/fpath.zsh" ]] && source "$ZSH_CONFIG_DIR/fpath.zsh"

# ---------------------------------------------------------------------------
# oh-my-zsh
# ---------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Keep the completion dump out of $HOME.
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump-${HOST}-${ZSH_VERSION}"
mkdir -p "${ZSH_COMPDUMP:h}"

# Remind rather than auto-update, so opening a shell never blocks on the network.
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14

# Big repos make the prompt's git status check slow; skip the untracked scan.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins are mostly aliases and completions, and each one costs startup time,
# so this list is trimmed to what actually gets used. Note there is no `nvm` or
# `rbenv` plugin -- mise handles node and ruby now (see zsh/tools.zsh).
plugins=(
  # --- vcs ---
  git
  git-lfs
  gh
  gitignore

  # --- languages & package managers ---
  node
  npm
  python
  pip
  rust
  golang
  ruby
  rails

  # --- infra ---
  docker
  docker-compose
  kubectl
  helm
  ansible
  terraform

  # --- macOS & tooling ---
  brew
  macos
  xcode
  1password
  vscode
  history-substring-search
  extract
  colorize
  colored-man-pages

  # Auto-loads .env when you cd into a directory that has one. Prompts for
  # confirmation the first time it sees each file.
  dotenv
)

source "$ZSH/oh-my-zsh.sh"

# ---------------------------------------------------------------------------
# Our configuration, split by concern. Order is significant: highlighting has to
# come last, after everything else has bound its ZLE widgets.
# ---------------------------------------------------------------------------
for _config in options history completion tools aliases functions highlighting; do
  [[ -r "$ZSH_CONFIG_DIR/$_config.zsh" ]] && source "$ZSH_CONFIG_DIR/$_config.zsh"
done
unset _config

# ---------------------------------------------------------------------------
# Machine-local overrides
#
# Secrets (API tokens, work-only config) live here, NOT in this repo.
# See .zshrc.local.example for the expected shape.
# ---------------------------------------------------------------------------
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
