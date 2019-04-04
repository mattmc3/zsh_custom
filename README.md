# zsh_custom

My personal [oh-my-zsh](omz) custom directory (`$ZSH_CUSTOM`) for ZSH shell happiness.

## Installation

### Pre-reqs

Install [oh-my-zsh](omz):

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### Install this repo in $ZSH_CUSTOM

You can replace the oh-my-zsh $ZSH_CUSTOM directory (~/.oh-my-zsh/custom)

```zsh
# be sure to install oh-my-zsh first
export ZSH_CUSTOM="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"
rm -rfi "$ZSH_CUSTOM"
git clone git@github.com:mattmc3/zsh_custom.git "$ZSH_CUSTOM"
```

Or, you can make a new one:

```zsh
# Edit your ~/.zshrc and add this line, replacing any existing ZSH_CUSTOM
export ZSH_CUSTOM="~/path/to/my/zsh_custom"

# Reload zsh and clone to the folder
source ~/.zshrc
git clone git@github.com:mattmc3/zsh_custom.git "$ZSH_CUSTOM"
```

## Root directory

Per oh-my-zsh docs:

> You can put files here to add functionality separated per file, which will be ignored by git.
> Files on the custom/ directory will be automatically loaded by the init script, in alphabetical order.
> For example: add yourself some shortcuts to projects you often work on.

```zsh
brainstormr=~/Projects/development/planetargon/brainstormr
cd $brainstormr
```

## Plugins

Custom plugins go in the plugins folder. Oh-my-zsh allows overriding its plugins
or making new ones.

External plugins are as simple as doing a `git clone --depth 1`. A script for
downloading my favorite ones is in the bin/clone_plugins.sh script.

```zsh
$ZSH_CUSTOM/bin/clone_plugins.sh
```

## Themes

Custom themes go in the themes folder.

[omz]: https://github.com/robbyrussell/oh-my-zsh
