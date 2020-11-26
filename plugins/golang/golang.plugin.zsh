source $ZSH/plugins/golang/golang.plugin.zsh

export GLOBALGOPATH=$HOME/Projects/golang
export GOPATH=$GLOBALGOPATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin # Add GOPATH/bin to PATH for scripting

for _f in "${0:h}/functions"/*(.N); do
  autoload -Uz "$_f"
done
unset _f
