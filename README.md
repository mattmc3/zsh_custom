# zsh_custom

My personal [oh-my-zsh][omz] custom directory (`$ZSH_CUSTOM`) for ZSH shell happiness.

## Installation

### Pre-reqs

Install [oh-my-zsh][omz]:

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Install this repo in $ZSH_CUSTOM

Make a `$ZSH_CUSTOM` directory:

```zsh
# Clone this repo
export ZSH_CUSTOM="${ZDOTDIR:-$HOME}/.zsh_custom"
git clone git@github.com:mattmc3/zsh_custom.git "$ZSH_CUSTOM"

# Edit your ~/.zshrc and add the ZSH_CUSTOM you just made to it
export ZSH_CUSTOM="${ZDOTDIR:-$HOME}/.zsh_custom"

# relaunch zsh
zsh
```

You could also replace the oh-my-zsh $ZSH_CUSTOM directory (`~/.oh-my-zsh/custom`)

```zsh
# if OMZ is installed already, then you should have a default ZSH_CUSTOM
# that points to ~/.oh-my-zsh/custom
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

Custom plugins go in the plugins folder. Oh-my-zsh allows overriding its plugins
or making new ones.

External plugins are handled as git submodules. Or, alternatively, doing a
`git clone --depth 1`.

## Themes

Custom themes go in the themes folder.

[omz]: https://github.com/ohmyzsh/ohmyzsh
