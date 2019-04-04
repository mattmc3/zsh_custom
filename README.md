# zsh_custom

My personal oh-my-zsh custom directory for ZSH shell happiness.

## Installation

```zsh
# be sure to install oh-my-zsh first
export ZSH_CUSTOM="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"
rm -rfi "$ZSH_CUSTOM"
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

External plugins are downloaded via the bin/clone_plugins.sh script

```zsh
$ZSH_CUSTOM/bin/clone_plugins.sh
```
