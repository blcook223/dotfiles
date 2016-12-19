[ -z "$PS1" ] && return

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias ll='ls -GFlahp'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ps='ps -f'
alias mkdir='mkdir -p'
alias c='clear'
alias path='echo -e ${PATH//:/\\n}'
alias ~='cd ~'
alias f='open -a Finder ./'
alias which='type -all'
alias ed='subl'
alias dnsflush='sudo discoveryutil mdnsflushcache;sudo discoveryutil udnsflushcaches;echo "DNS cache flushed"'
alias myip='curl ip.appspot.com'
alias connections='lsof -i'
alias dl='~/utils/download.sh'

headers() { /usr/bin/curl -I -L $@ ; }
trash() { command mv "$@" ~/.Trash ; }
cd() { builtin cd "$@"; ll; }

# modified from https://coderwall.com/p/pn8f0g/show-your-git-status-and-branch-in-color-at-the-command-prompt
function _git_status {
  local git_status="$(git status 2> /dev/null)"
  local git_status_short="$(git status -sb 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  local commits_ahead="ahead ([0-9]+)"
  local commits_behind="behind ([0-9]+)"

  local tags=

  if [[ ! $git_status =~ "working tree clean" ]]; then
    tags+='*'
  fi
  if [[ $git_status_short =~ $commits_ahead ]]; then
    tags+="+${BASH_REMATCH[1]}"
  fi
  if [[ $git_status_short =~ $commits_behind ]]; then
    tags+="-${BASH_REMATCH[1]}"
  fi
  if [[ $tags ]]; then
    tags="|$tags"
  fi

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch$tags)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit$tags)"
  fi
}

function _prompt {
  local BLUE="\[\033[0;94m\]"
  local PURPLE="\[\033[0;95m\]"
  local CYAN="\[\033[1;96m\]"
  local GREEN="\[\033[0;32m\]"
  local RESETCOLOR="\[\e[00m\]"

  export PS1="$BLUE[$CYAN\u$BLUE@$CYAN\h$BLUE:$CYAN\W$BLUE]$GREEN\$(_git_status)$PURPLE\$ $RESETCOLOR"
}

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
#export EDITOR="subl -w"
export EDITOR="vim"
export BLOCKSIZE=1k

_prompt

# Sublime Text
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

# PostgreSQL
export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"

# MySQL
export PATH="/usr/local/mysql/bin:$PATH"

# phpenv
# export PATH="$HOME/.phpenv/bin:$PATH"
# eval "$(phpenv init -)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# nodenv
# export PATH="$HOME/.nodenv/bin:$PATH"
# eval "$(nodenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# eval "$(pyenv virtualenvwrapper -)"


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# added by Anaconda2 4.0.0 installer
export PATH="/Users/bcook/anaconda/bin:$PATH"
