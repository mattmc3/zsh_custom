#
# golang
#

# export GLOBALGOPATH=$XDG_PROJECTS_DIR/golang

export GOPATH="${GOPATH:-${XDG_DATA_HOME:-$HOME/.local/share}/go}"
export GOMODCACHE="${GOMODCACHE:-${XDG_CACHE_HOME:-$HOME/.cache}/go/mod}"
path+=($GOPATH/bin(N))

alias gob="go build"
alias goc="go clean"
alias god="go doc"
alias gof="go fmt"
alias gofa="go fmt ./..."
alias gog="go get"
alias goi="go install"
alias gol="go list"
alias gop="cd \$GOPATH"
alias gopb="cd \$GOPATH/bin"
alias gops="cd \$GOPATH/src"
alias gor="go run"
alias got="go test"
alias gov="go vet"
