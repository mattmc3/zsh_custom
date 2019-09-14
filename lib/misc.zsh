# autoload -Uz is-at-least

# https://apple.stackexchange.com/questions/312795/zsh-paste-from-the-clipboard-a-command-takes-a-few-second-to-be-write-in-the-ter
# # *-magic is known buggy in some versions; disable if so
# if [[ $DISABLE_MAGIC_FUNCTIONS != true ]]; then
#   for d in $fpath; do
#   	if [[ -e "$d/url-quote-magic" ]]; then
#   		if is-at-least 5.1; then
#   			autoload -Uz bracketed-paste-magic
#   			zle -N bracketed-paste bracketed-paste-magic
#   		fi
#   		autoload -Uz url-quote-magic
#   		zle -N self-insert url-quote-magic
#       break
#   	fi
#   done
# fi

## jobs
setopt long_list_jobs

PAGER="${PAGER:-less}"
LESS="${LESS:--R}"

## super user alias
alias _='sudo'

## more intelligent acking for ubuntu users
if which ack-grep &> /dev/null; then
  alias afind='ack-grep -il'
else
  alias afind='ack -il'
fi

# recognize comments
setopt interactivecomments
