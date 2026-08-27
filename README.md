# dotfiles

My shell, git, vim and terminal configuration. macOS + zsh.

Installed and symlinked by [mac-dev-playbook](https://github.com/ekryski/mac-dev-playbook),
but the repo stands on its own — see [Manual install](#manual-install).

## Layout

| Path | What it is |
|---|---|
| `.zshenv` | Sourced by *every* zsh, interactive or not. XDG dirs and cargo. Kept side-effect free. |
| `.zprofile` | Login shells. Homebrew, `PATH`, `EDITOR`, locale. |
| `.zshrc` | Interactive shells. oh-my-zsh, then the `zsh/` modules, then `~/.zshrc.local`. |
| `zsh/fpath.zsh` | Completion search path. Sourced **before** oh-my-zsh, which runs `compinit`. |
| `zsh/options.zsh` | `setopt` — globbing, `AUTO_CD`, safety. |
| `zsh/history.zsh` | 100k shared, deduplicated history under `~/.local/state/zsh`. |
| `zsh/completion.zsh` | `zstyle` completion behaviour, autosuggestions, key bindings. |
| `zsh/tools.zsh` | mise, uv, zoxide, fzf, gpg, gcloud init. |
| `zsh/aliases.zsh` | Aliases. |
| `zsh/functions.zsh` | Functions — anything needing arguments or logic. |
| `zsh/highlighting.zsh` | `zsh-syntax-highlighting`. **Must load last.** |
| `.gitconfig` | Git. No identity in it — see below. |
| `.gitignore_global` | Machine cruft only, not project build output. |
| `.vimrc` | Minimal, dependency-free vim for commit messages and remote shells. |
| `.inputrc` | readline — applies to `psql`, `irb`, `sqlite3`, not to zsh. |
| `.editorconfig` | Baseline formatting for projects without their own. |
| `config/ghostty/config` | Ghostty terminal. |
| `config/mise/config.toml` | Fallback runtime versions (the playbook overwrites this). |

## Secrets

**Nothing secret is committed here.** `~/.zshrc` sources `~/.zshrc.local` last if it
exists; that file is not in this repo and never should be.

```bash
cp .zshrc.local.example ~/.zshrc.local
chmod 600 ~/.zshrc.local
$EDITOR ~/.zshrc.local
```

Git identity works the same way: `.gitconfig` ends with
`[include] path = ~/.gitconfig.local`, and the playbook writes name, email and
signing key into that local file.

## Version management

One manager per language, no overlap:

| Language | Tool | Where versions are set |
|---|---|---|
| node, ruby, go | [mise](https://mise.jdx.dev) | `~/.config/mise/config.toml`, or a per-project `.mise.toml` / `.tool-versions` |
| python | [uv](https://docs.astral.sh/uv/) | `~/.python-version`, or a per-project `.python-version` / `pyproject.toml` |
| rust | rustup | `rust-toolchain.toml` |

`nvm` is installed but **not** loaded — its shims and mise's fight over `PATH`.
To switch node back to nvm, uncomment the block in `.zprofile` and drop `node`
from the mise config.

## Manual install

```bash
git clone https://github.com/ekryski/dotfiles.git ~/Development/personal/dotfiles
cd ~/Development/personal/dotfiles
```

Then link what you want:

```bash
ln -sf "$PWD/.zshenv"           ~/.zshenv
ln -sf "$PWD/.zprofile"         ~/.zprofile
ln -sf "$PWD/.zshrc"            ~/.zshrc
ln -sfn "$PWD/zsh"              ~/.zsh
ln -sf "$PWD/.gitconfig"        ~/.gitconfig
ln -sf "$PWD/.gitignore_global" ~/.gitignore_global
ln -sf "$PWD/.inputrc"          ~/.inputrc
ln -sf "$PWD/.vimrc"            ~/.vimrc
ln -sf "$PWD/.editorconfig"     ~/.editorconfig
mkdir -p ~/.config
ln -sfn "$PWD/config/ghostty"   ~/.config/ghostty
ln -sfn "$PWD/config/mise"      ~/.config/mise
```

The zsh config expects these, all installed by the playbook:

```bash
brew install zsh-completions zsh-autosuggestions zsh-syntax-highlighting \
             mise uv fzf fd bat eza ripgrep zoxide git-delta
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Missing tools degrade gracefully — every integration is behind a
`command -v` check, and `ls`/`cat` fall back to the builtins.

## Handy bits

| Command | Does |
|---|---|
| `src` | `exec zsh` — full restart, not a re-source |
| `zsh-benchmark [n]` | Time `n` shell startups |
| `zsh-refresh-completions` | Clear the completion cache after upgrading a tool |
| `killport 3000` | Kill whatever is holding a port |
| `gcof` | Fuzzy-checkout a branch |
| `prune-branches` | Delete every local branch already merged |
| `mkcd foo/bar` | `mkdir -p` and `cd` |

Originally forked from [geerlingguy/dotfiles](https://github.com/geerlingguy/dotfiles).
