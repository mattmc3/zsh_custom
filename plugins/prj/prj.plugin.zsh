#
# prj: The project jumper
#

(( $+commands[fd] && $+commands[fzf] && $+commands[zoxide] )) || return 1

# Every git project under $PRJ_DIR, by zoxide frecency, then alphabetical.
function _prj_projects {
  emulate -L zsh
  setopt extended_glob
  local root=${PRJ_DIR:-${XDG_PROJECTS_DIR:-$HOME/Projects}}
  local -A score
  local line
  for line in ${(f)"$(zoxide query -ls --base-dir $root 2>/dev/null)"}; do
    line=${line##[[:space:]]#}
    score[${${line#*[[:space:]]}#$root/}]=${line%%[[:space:]]*}
  done

  local -a projects=(${(f)"$(fd --type d --base-directory $root --hidden --no-ignore-vcs --max-depth 5 '\.git$')"})
  projects=(${(u)${projects%/.git(/|)}})

  local p
  for p in $projects; do
    print -r -- "${score[$p]:-0}"$'\t'"$p"
  done | sort -t $'\t' -k1,1nr -k2,2 | cut -f2-
}

# prj            pick a project with fzf
# prj <query>    jump to the most frecent project that fuzzy matches
# prj <path>     jump to that project, as completed by `prj <TAB>`
# fzf runs with --no-sort everywhere, so frecency order wins over match score.
function prj {
  local root=${PRJ_DIR:-${XDG_PROJECTS_DIR:-$HOME/Projects}} pick
  if [[ ! -d $root ]]; then
    print -ru2 "prj: project directory not found '$root'"
    return 1
  fi

  if [[ -n $1 && -d $root/$1/.git ]]; then
    pick=$1
  elif (( $# )); then
    pick=$(_prj_projects | fzf --filter="$*" --no-sort | head -n 1)
  else
    pick=$(_prj_projects | fzf --layout=reverse-list --no-sort)
  fi

  if [[ -z $pick ]]; then
    (( $# )) && print -ru2 "prj: no project matches '$*'"
    return 1
  fi

  cd -- $root/$pick || return
  # zoxide's chpwd hook records the visit; without it, record it ourselves.
  (( ${chpwd_functions[(Ie)__zoxide_hook]} )) || zoxide add -- $PWD
}

# Completes projects in rank order; fzf-tab turns this into an fzf picker.
# -U skips zsh's matching so fzf does the fuzzy match on what you typed.
function _prj {
  (( CURRENT == 2 )) || return 1
  local -a projects=(${(f)"$(_prj_projects)"})
  compadd -U -V projects -Q -a projects
}
compdef _prj prj
# fzf-tab sorts candidates unless told not to, then fzf sorts by match score.
zstyle ':completion:*:prj:*' sort false
zstyle ':fzf-tab:complete:prj:*' fzf-flags --no-sort
