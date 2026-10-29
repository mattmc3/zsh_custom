#
# fzf: Stock plugin plus fzf-tab friendly completion styles.
#

source $ZSH/plugins/fzf/fzf.plugin.zsh

# fzf-tab ignores %F{}/%f prompt-escape sequences in completion format
# zstyles (see fzf-tab README "Configure" section) - reset to plain text
# so headers don't leak raw escape codes into the fzf display.
zstyle ':completion:*:corrections' format ' -- %d (errors: %e) --'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:messages' format ' -- %d --'
zstyle ':completion:*:warnings' format ' -- no matches found --'
zstyle ':completion:*' format '[%d]'

# _match/_approximate are redundant once fzf-tab provides interactive
# fuzzy filtering, and their "original"/"corrections" group headers
# get squashed together under group-name ''. Plain completion only.
zstyle ':completion:*' completer _complete

# No dot marking each entry's group. The legend row already names the colors.
zstyle ':fzf-tab:*' prefix ''
