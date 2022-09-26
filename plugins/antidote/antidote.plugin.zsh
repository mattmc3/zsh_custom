ANTIDOTE_DIR=$ZDOTDIR/.antidote
ANTIDOTE_HOME=$ZSH_CUSTOM/.external
[[ -e $ANTIDOTE_DIR ]] ||
  git clone git@github.com:mattmc3/antidote $ANTIDOTE_DIR

autoload -Uz $ANTIDOTE_DIR/functions/antidote
zstyle ':antidote:bundle' use-friendly-names 'yes'
