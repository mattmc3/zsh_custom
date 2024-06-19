# clone repos
export REPO_HOME=$(repo home)
[[ -d $REPO_HOME ]] || repo in <$ZSH_CUSTOM/repos.txt
