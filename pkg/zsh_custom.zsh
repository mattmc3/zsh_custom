#!/usr/bin/env zsh
# zsh_custom plugin loader
# Home: https://github.com/mattmc3/zsh_custom
# License: MIT
#
# Sourced from .zshrc after setting the `plugins` array. Entries can be:
#   plugin-name              -> loaded from $ZSH_CUSTOM_DIR/plugins/<name>
#   user/repo                -> cloned from https://github.com/user/repo into external/
#   user/repo#<sha|ref>      -> same, pinned to the given commit/ref
#   https://host/user/repo   -> cloned verbatim from the given URL into external/

0=${(%):-%N}
: ${ZSH_CUSTOM_DIR:=${0:a:h:h}}
typeset -g ZSH_CUSTOM_DIR

function zsh_custom_clone {
  emulate -L zsh
  setopt local_options extended_glob no_monitor

  local plugin repo repo_url commitsha repo_dir current_sha canonical
  local -a clone_args candidates

  mkdir -p "$ZSH_CUSTOM_DIR/external"

  for plugin in $@; do
    [[ "$plugin" == */* ]] || continue

    commitsha=""
    repo="$plugin"
    clone_args=(--quiet --depth 1 --recursive --shallow-submodules)
    if [[ "$plugin" == *'#'* ]]; then
      commitsha="${plugin##*\#}"
      repo="${plugin%\#*}"
      clone_args+=(--no-checkout)
    fi

    repo_url="https://github.com/$repo"
    if [[ "$repo" == (https://|http://|git@|ssh://|git://)* ]]; then
      repo_url="$repo"
      repo="${repo:h:t}/${repo:t}"
    fi

    repo_dir="$ZSH_CUSTOM_DIR/external/${repo:t}"
    {
      if [[ ! -d "$repo_dir" ]]; then
        echo "Cloning $repo..."
        git clone "${clone_args[@]}" "$repo_url" "$repo_dir"
        if [[ -n "$commitsha" ]]; then
          git -C "$repo_dir" fetch --quiet origin "$commitsha"
          git -C "$repo_dir" checkout --quiet "$commitsha"
          git -C "$repo_dir" config zsh_custom.pinned "$commitsha"
        fi
      elif [[ -n "$commitsha" ]]; then
        current_sha=$(git -C "$repo_dir" rev-parse HEAD 2>/dev/null)
        if [[ "$current_sha" != "$commitsha"* ]]; then
          echo "Pinning ${repo:t} to $commitsha..."
          git -C "$repo_dir" fetch --quiet origin "$commitsha" 2>/dev/null || true
          git -C "$repo_dir" checkout --quiet "$commitsha" 2>/dev/null || true
        fi
        git -C "$repo_dir" config zsh_custom.pinned "$commitsha"
      else
        git -C "$repo_dir" config --unset zsh_custom.pinned 2>/dev/null || true
      fi

      # Ensure a canonical <name>.plugin.zsh exists so load is a fixed-cost lookup.
      canonical="$repo_dir/${repo:t}.plugin.zsh"
      if [[ ! -e "$canonical" ]]; then
        candidates=(
          "$repo_dir"/*.plugin.zsh(N)
          "$repo_dir"/*.zsh-theme(N)
          "$repo_dir"/*.zsh(N)
          "$repo_dir"/*.sh(N)
        )
        (( $#candidates )) && ln -sf "${candidates[1]:t}" "$canonical"
      fi
    } &
  done
  wait
}

function zsh_custom_update {
  emulate -L zsh
  setopt local_options extended_glob

  local repo pinned_sha

  # Reconcile array vs on-disk pin state before walking, so pin changes
  # (added, removed, moved) take effect without requiring a shell restart.
  zsh_custom_clone $plugins

  for repo in "$ZSH_CUSTOM_DIR"/external/*/.git(N); do
    repo="${repo:a:h}"
    pinned_sha=$(git -C "$repo" config --get zsh_custom.pinned 2>/dev/null)
    if [[ -n "$pinned_sha" ]]; then
      echo "Skipping pinned repo: ${repo:t} ($pinned_sha)"
      continue
    fi
    echo "Updating ${repo:t}..."
    git -C "$repo" pull --quiet --ff --rebase --autostash
  done
}

function zsh_custom_load {
  emulate -L zsh
  setopt local_options extended_glob

  local plugin name plugin_dir initfile loaded

  for plugin in $plugins; do
    name="${${plugin%\#*}:t}"
    # Prefer a plugins/<name> wrapper, fall back to the cloned external/<name>.
    if [[ -e "$ZSH_CUSTOM_DIR/plugins/$name/$name.plugin.zsh" ]]; then
      plugin_dir="$ZSH_CUSTOM_DIR/plugins/$name"
    elif [[ -e "$ZSH_CUSTOM_DIR/external/$name/$name.plugin.zsh" ]]; then
      plugin_dir="$ZSH_CUSTOM_DIR/external/$name"
    else
      echo >&2 "zsh_custom: no $name.plugin.zsh found in plugins/$name or external/$name"
      continue
    fi

    initfile="$plugin_dir/$name.plugin.zsh"
    fpath+=("$plugin_dir")
    source "$initfile" && loaded=yes || loaded=no
    zstyle ":zsh_custom:plugin:$name" loaded $loaded
  done
}

zsh_custom_clone $plugins
zsh_custom_load
