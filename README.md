# zsh_custom

My personal [oh-my-zsh][omz] custom directory (`$ZSH_CUSTOM`) for ZSH shell happiness.

Works great with [prezto] or with any plugin manager like [antibody] too.

## Installation

### Clone the repo

Make a `$ZSH_CUSTOM` directory and clone into it:

```zsh
# clone this repo
export ZSH_CUSTOM="${ZDOTDIR:-$HOME}/.zsh_custom"
git clone https://github.com/mattmc3/zsh_custom.git "$ZSH_CUSTOM"
```

### Oh My Zsh

If you haven't already, install [oh-my-zsh][omz]:

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Edit your `~/.zshrc` and add `ZSH_CUSTOM` to it

```zsh
# edit your ~/.zshrc and add the ZSH_CUSTOM variable you just made to it
export ZSH_CUSTOM="${ZDOTDIR:-$HOME}/.zsh_custom"
```

Alternatively, you could replace the oh-my-zsh $ZSH_CUSTOM directory (`~/.oh-my-zsh/custom`)

```zsh
# if OMZ is installed already, then you should have a default ZSH_CUSTOM
# that points to ~/.oh-my-zsh/custom
rm -rfi "$ZSH_CUSTOM"
git clone https://github.com/mattmc3/zsh_custom.git "$ZSH_CUSTOM"
```

### Prezto

Edit your .zpreztorc and add the following

```zsh
zstyle ':prezto:load' pmodule-dirs ${ZDOTDIR:-$HOME}/.zsh_custom/plugins
```

### Antibody

Install [antibody]:

```zsh
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
```

Add plugins to your ~/.zsh_plugins.txt

```zsh
$ZSH_CUSTOM/plugins/python
```

Add these lines to your ~/.zshrc

```zsh
export ZSH_CUSTOM=${ZDOTDIR:-$HOME}/.zsh_custom
source <(antibody init)
envsubst < ${ZDOTDIR:-$HOME}/.zsh_plugins | antibody bundle
```

### Wrapping up

And finally, relaunch your zsh

```zsh
zsh
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
[prezto]: https://github.com/sorin-ionescu/prezto
[antibody]: https://getantibody.github.io/
