mkdir -p $ZSH_CUSTOM/external/github.com/zsh-users
cd $ZSH_CUSTOM/external/github.com/zsh-users
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-completions
git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting

mkdir -p $ZSH_CUSTOM/external/github.com/zdharma
cd $ZSH_CUSTOM/external/github.com/zdharma
git clone --depth 1 https://github.com/zdharma/fast-syntax-highlighting

mkdir -p $ZSH_CUSTOM/external/github.com/mafredri
cd $ZSH_CUSTOM/external/github.com/mafredri
git clone --depth 1 https://github.com/mafredri/zsh-async
