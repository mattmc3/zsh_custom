source "$ZSH"/plugins/common-aliases/common-aliases.plugin.zsh

# https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
# https://github.com/webpro/dotfiles/blob/master/system/.alias
# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases

# zsh only aliases {{{
alias cd..='cd ..'
alias -g ..2='../..'
alias -g ..3='../../..'
alias -g ..4='../../../..'
alias -g ..5='../../../../..'

alias zshrc='ide "${ZDOTDIR:-$HOME}"/.zshrc'
alias reload='source "${ZDOTDIR:-$HOME}"/.zshrc'

# zsh pipes
alias -g S='| sort'


# mask built-ins with better defaults
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias ping='ping -c 5'

# be safe
alias cpi='cp -i'
alias mvi='mv -i'
alias rmi='rm -i'

#alias rm='echo "STOP using rm! Use \"safe-rm\" instead. Removing anyway." && safe-rm "$@"'
#alias del='safe-rm -i'

# single character shortcuts - be sparing!
alias _='sudo'
alias c='clear'
alias d='dirs -v | head -10'
alias v='nvim'
alias h='history'

# shortcuts
alias vi='nvim'
alias vim='nvim'
alias oldvim='\vim'
alias cl='clear'
alias afind='ack -il'
alias md='mkdir -p'
alias rd=rmdir
alias please=sudo
alias po=popd
alias pu=pushd
alias zz=exit
alias globurl='noglob urlglobber '

# ls
alias ls='ls -GF'
alias ll='ls -lFh'
alias l='ls -F'
alias la='ls -lAFh'
alias ldot='ls -ld .*'

# fix typos
alias quit='exit'

# tools
alias te="$EDITOR"
alias ide="$VISUAL"

# network
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias dnsflush="dscacheutil -flushcache && killall -HUP mDNSResponder"
alias speedtest="wget -O /dev/null http://speed.transip.nl/10mb.bin"
alias pinging="command ping"

# other aliases
alias tarls="tar -tvf"
alias untar="tar -xf"
alias biggest='du -s ./* | sort -nr | awk '\''{print $2}'\'' | xargs du -sh'
alias dux='du -x --max-depth=1 | sort -n'
alias path='echo -e ${PATH//:/\\n}'
alias linecount="grep -c '^'"
alias ex="exit"
alias ds="date +%Y%m%d"
alias ts="date +%Y%m%d%H%M%S"
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
alias datestamp="date '+%Y-%m-%d'"
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias dud='du -d 1 -h'
alias duf='du -sh *'
