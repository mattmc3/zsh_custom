#
antibody bundle zsh-users/zsh-completions path:src kind:fpath

# Initialize completions at the end
hooks-add-hook postzshrc_hook compinit-fast
