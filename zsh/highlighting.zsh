# Syntax highlighting must be sourced LAST -- it wraps every ZLE widget that
# exists at the time it loads, so anything sourced afterwards is not highlighted.

if [[ -r "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
