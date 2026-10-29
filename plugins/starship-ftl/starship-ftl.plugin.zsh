#
# starship-ftl: Faster-than-light starship prompt, and transient prompts.
#

0=${(%):-%N}

# Clone into repos/ so `omz+ update` pulls it.
_ftl_dir=${ZSH_CUSTOM:-$ZSH/custom}/repos/starship-ftl
[[ -d $_ftl_dir ]] ||
  git clone -q --depth 1 https://github.com/mattmc3/starship-ftl $_ftl_dir
source $_ftl_dir/starship-ftl.plugin.zsh

# OMZ sources themes after plugins, too late to draw early, so the starship
# theme's FTL work happens here. The theme sees it already ran and stops.
if [[ "$ZSH_THEME" == starship ]] && (( $+commands[starship] )); then
  if zstyle -s ':zsh_custom:theme:starship' config _ftl_cfg; then
    [[ -r ${0:A:h:h:h}/themes/$_ftl_cfg.toml ]] &&
      _ftl_cfg=${0:A:h:h:h}/themes/$_ftl_cfg.toml
  fi
  ftl-prompt starship $_ftl_cfg
  zstyle -t ':zsh_custom:theme:starship' transient && ftl-transient on
fi
unset _ftl_{dir,cfg}
