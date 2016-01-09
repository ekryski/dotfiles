#
# .bash_profile
#
# @author Eric Kryski
# @see .inputrc
#

# Nicer prompt. Looks like this:
# <username> : <current directory> (<git branch>)
export PS1="\[\033[01;30m\]\u : \[\033[01;34m\]\W\[\033[m\] \[\033[31m\]\$(parse_git_branch) \[\033[00m\]\$ "

# Use colors.
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Custom $PATH with extra locations.
export PATH=/usr/local/bin:/Users/ekryski/bin:/usr/local/sbin:/usr/local/git/bin:$PATH

# GO Lang Paths
export GOPATH=$HOME/Development/go
export PATH=$PATH:$GOPATH/bin

# Android Development Paths
export PATH=$PATH:/Developer/Eclipse/android-sdk-macosx/platform-tools:/Developer/Eclipse/android-sdk-macosx/tools

# Load RVM into shell session
export PATH="$HOME/.rvm/bin:$PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# Load NVM into shell session
export NVM_DIR=$HOME/.nvm
source $(brew --prefix nvm)/nvm.sh  # This loads NVM into a shell session.

# Flush DNS cache (See: http://support.apple.com/kb/ht5343).
alias flush-dns='sudo killall -HUP mDNSResponder'

# Include alias file (if present) containing aliases for ssh, etc.
if [ -f ~/.bash_aliases ]
then
  source ~/.bash_aliases
fi

# Include bashrc file (if present).
if [ -f ~/.bashrc ]
then
  source ~/.bashrc
fi

# Route local traffic over ethernet when using certain WiFi networks w/o proxy.
function route_add() {
  sudo route add -net 10.0.0.0/8 -interface en0
}

# Delete the route added above.
function route_delete() {
  sudo route delete 10.0.0.0
}

# Route IRC traffic through one of my servers.
# Use SOCKS5 settings 'localhost' and 6667 for server/port.
function irc_proxy() {
  ssh -vD 6667 geerlingguy@atl1.servercheck.in
}

# Syntax-highlight code for copying and pasting.
# Requires highlight (`brew install highlight`).
function pretty() {
  pbpaste | highlight --syntax=$1 -O rtf | pbcopy
}

# Git aliases.
alias gs='git status'
alias gc='git commit'
alias gp='git pull --rebase'
alias gcam='git commit -am'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gsd='git svn dcommit'
alias gsfr='git svn fetch && git svn rebase'

# Turn on Git autocomplete.
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Make Ruby go faster
# https://gist.github.com/ekryski/3ab7d82505684ecbb891
export RUBY_HEAP_MIN_SLOTS=500000
export RUBY_HEAP_SLOTS_INCREMENT=250000 # not available in MRI
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=50000000
export RUBY_FREE_MIN=100000 # deprecated in Ruby 2.1

# Vagrant configuration.
# export VAGRANT_DEFAULT_PROVIDER='virtualbox'

# Ansible aliases.
alias an='ansible'
alias ap='ansible-playbook'

# Ask for confirmation when 'prod' is in a command string.
prod_command_trap () {
  if [[ $BASH_COMMAND == *prod* ]]
  then
    read -p "Are you sure you want to run this command on prod [Y/n]? " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      echo -e "\nRunning command \"$BASH_COMMAND\" \n"
    else
      echo -e "\nCommand was not run.\n"
      return 1
    fi
  fi
}
shopt -s extdebug
trap prod_command_trap DEBUG
