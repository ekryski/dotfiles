# Shell behaviour.

# --- directory navigation ---
setopt AUTO_CD              # `foo` instead of `cd foo`
setopt AUTO_PUSHD           # every cd pushes onto the directory stack
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# --- globbing ---
setopt EXTENDED_GLOB        # ^, ~ and # become glob operators
setopt GLOB_DOTS            # * matches dotfiles too
setopt NO_CASE_GLOB         # case-insensitive globbing
unsetopt NOMATCH            # pass unmatched globs through instead of erroring

# --- correction & safety ---
setopt INTERACTIVE_COMMENTS # allow # comments in an interactive shell
unsetopt BEEP
unsetopt CORRECT_ALL        # zsh guessing at your typos causes more harm than good

# --- job control ---
setopt LONG_LIST_JOBS
setopt NO_HUP               # don't kill background jobs when the shell exits
