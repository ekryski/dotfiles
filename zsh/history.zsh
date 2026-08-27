# History. Large, shared across sessions, and deduplicated.

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "${HISTFILE:h}"

HISTSIZE=100000            # entries kept in memory
SAVEHIST=100000            # entries written to $HISTFILE

setopt EXTENDED_HISTORY     # record timestamp and duration
setopt INC_APPEND_HISTORY   # write as you go, not just on exit
setopt SHARE_HISTORY        # new shells see commands from existing ones
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE    # a leading space keeps a command out of history
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY          # expand !! and let you look before running it

# Commands not worth remembering.
HISTORY_IGNORE="(ls|ll|cd|cd ..|pwd|exit|clear|c|history)"
