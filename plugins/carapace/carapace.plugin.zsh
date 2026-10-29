#
# carapace: Cross shell completions.
#

(( $+commands[carapace] )) || return 1
export CARAPACE_BRIDGES="${CARAPACE_BRIDGES:-fish,bash}"
cached-eval carapace-init-zsh carapace _carapace
