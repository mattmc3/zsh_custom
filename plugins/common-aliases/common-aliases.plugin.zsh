#
# Aliases
#

# https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
# https://github.com/webpro/dotfiles/blob/master/system/.alias
# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh

# zsh suffix aliases
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep -E'
alias -g S='| sort'
alias -g L='| less'
alias -g M='| more'

# single character shortcuts - be sparing!
alias -- -='cd -'
alias _=sudo
alias l=ls

# mask built-ins with better defaults
# alias cp='cp -i'
# alias mv='mv -i'
# alias rm='rm -i'
alias mkdir='mkdir -p'
alias ping='ping -c 5'
alias type='type -a'
alias vi=vim
if [[ "$OSTYPE" == darwin* ]]; then
  alias ls="ls -G"
else
  alias ls="ls --group-directories-first --color=auto"
fi

# grep
typeset -gHa _grep_exclude_dirs
zstyle -a ':zsh_custom:plugin:common-aliases:grep' 'exclude-dirs' '_grep_exclude_dirs' \
  || _grep_exclude_dirs=(.bzr CVS .git .hg .svn .idea .tox)
alias grep="${aliases[grep]:-grep} --exclude-dir={${(j:,:)_grep_exclude_dirs}}"
unset _grep_exclude_dirs

# Better ls default flags.
alias ls="${aliases[ls]:-ls} -h"
if (( $+commands[dircolors] )) || ! is-macos; then
  alias ls="${aliases[ls]:-ls} --group-directories-first"
fi

# More ways to ls.
alias ll='ls -lh'
alias la='ls -lAh'
alias ldot='ls -ld .*'

# fix typos
alias quit='exit'
alias cd..='cd ..'
alias zz='exit'

# tar
alias tarls="tar -tvf"
alias untar="tar -xf"

# date/time
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
alias datestamp="date '+%Y-%m-%d'"
alias isodate="date +%Y-%m-%dT%H:%M:%S%z"
alias utc="date -u +%Y-%m-%dT%H:%M:%SZ"
alias unixepoch="date +%s"

# find
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# disk usage
alias biggest='du -s ./* | sort -nr | awk '\''{print $2}'\'' | xargs du -sh'
alias dux='du -x --max-depth=1 | sort -n'
alias dud='du -d 1 -h'
alias duf='du -sh *'

# url encode/decode
alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'

# misc
alias please=sudo
alias zshrc='${EDITOR:-vim} "${ZDOTDIR:-$HOME}"/.zshrc'
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'
alias zdot='cd $ZDOTDIR'
alias zcust='cd $ZSH_CUSTOM'
alias cls="clear && printf '\e[3J'"

# print things
alias println="printf '%s\n'"
alias funclist='print -l ${(k)functions[(I)[^_]*]} | sort'

# auto-orient images based on exif tags
alias autorotate="jhead -autorot"

# java
alias setjavahome="export JAVA_HOME=\`/usr/libexec/java_home\`"

# todo-txt
alias t="todo.sh"
alias todos="$VISUAL $HOME/Desktop/todo.txt"

# vscode
if [[ "$OSTYPE" == darwin* ]]; then
  alias code="open -b com.microsoft.VSCode"
fi
