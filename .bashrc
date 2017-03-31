#
# .bashrc
#
# @author Eric Kryski
# @see .inputrc

# Include alias file (if present) containing aliases for ssh, etc.
if [ -f ~/.bash_aliases ]
then
  source ~/.bash_aliases
fi

# Nicer prompt. Looks like this:
# <username> : <current directory> (<git branch>)
export PS1="\[\033[01;30m\]\u : \[\033[01;34m\]\W\[\033[m\] \[\033[31m\]\$(parse_git_branch) \[\033[00m\]\$ "

# Use colors.
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Custom $PATH with extra locations.
export PATH=/usr/local/bin:/Users/ekryski/bin:/usr/local/sbin:/usr/local/git/bin:$PATH

# ------------------------------------
# GO Lang Paths
# ------------------------------------
export GOPATH=$HOME/Development/go
export PATH=$PATH:$GOPATH/bin

# ------------------------------------
# Android Development Paths
# ------------------------------------
export ANDROID_HOME=/usr/local/opt/android-sdk

# ------------------------------------
# Virtualenv Wrapper
# 
# This loads Virtualenv wrapper into a shell session. 
# ------------------------------------
source /usr/local/bin/virtualenvwrapper.sh

# ------------------------------------
# Load NVM into shell session
# ------------------------------------
export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads NVM into a shell session.

# ------------------------------------
# Postgres
# ------------------------------------
export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

# Adding local dir /bin dir to last in chain
export PATH="./bin:$PATH"

# ------------------------------------
# Make Ruby go faster
# https://gist.github.com/ekryski/3ab7d82505684ecbb891
# ------------------------------------
export RUBY_GC_HEAP_INIT_SLOTS=500000
export RUBY_GS_HEAP_SLOTS_INCREMENT=250000 # not available in MRI
export RUBY_GC_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=50000000
export RUBY_GC_HEAP_FREE_SLOTS=100000 # deprecated in Ruby 2.1

# ------------------------------------
# Load RVM into shell session
# ------------------------------------
export PATH="$HOME/.rvm/bin:$PATH"

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# ------------------------------------
# Git aliases.
# ------------------------------------
alias gs='git status'
alias gc='git commit'
alias gp='git pull --rebase'
alias gcam='git commit -am'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gsd='git svn dcommit'
alias gsfr='git svn fetch && git svn rebase'
alias prune_all='git branch --merged | grep -v \"\\*\" | xargs -n 1 git branch -d'

# Turn on Git autocomplete.
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Parse git branch to show in customized prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}


# ------------------------------------
# Ansible aliases.
# ------------------------------------

alias an='ansible'
alias ap='ansible-playbook'

# Vagrant configuration.
# export VAGRANT_DEFAULT_PROVIDER='virtualbox'

# ------------------------------------
# Docker aliases and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"
# Get container process
alias dps="docker ps"
# Get process included stop container
alias dpa="docker ps -a"
# Get images
alias di="docker images"
# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"
# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"
# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"
# Stop all containers
dstop() { docker stop $(docker ps -a -q); }
# Remove all containers
drm() { docker rm $(docker ps -a -q); }
# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
# Remove all images
dri() { docker rmi $(docker images -q); }
# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker build -t=$1 .; }
# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }


# ------------------------------------
# Networking
# ------------------------------------

# Route local traffic over ethernet when using certain WiFi networks w/o proxy.
function route_add() {
  sudo route add -net 10.0.0.0/8 -interface en0
}

# Delete the route added above.
function route_delete() {
  sudo route delete 10.0.0.0
}


# ------------------------------------
# Generic Commands
# ------------------------------------

# Flush DNS cache (See: http://support.apple.com/kb/ht5343).
alias flush-dns='sudo killall -HUP mDNSResponder'
alias ..='cd ..'
alias c='clear'

# Syntax-highlight code for copying and pasting.
# Requires highlight (`brew install highlight`).
function pretty() {
  pbpaste | highlight --syntax=$1 -O rtf | pbcopy
}

# Ask for confirmation when 'prod' is in a command string.
# prod_command_trap () {
#   if [[ $BASH_COMMAND =~ "prod" ]]
#   then
#     read -p "Are you sure you want to run this command on prod [Y/n]? " -n 1 -r
#     if [[ $REPLY =~ ^[Yy]$ ]]
#     then
#       echo -e "\nRunning command \"$BASH_COMMAND\" \n"
#     else
#       echo -e "\nCommand was not run.\n"
#       return 1
#     fi
#   fi
# }

# trap prod_command_trap DEBUG