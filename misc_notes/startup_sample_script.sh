# Prompt coloring
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export PROMPT='%B%F{magenta}%/%f%b %# '

alias ls='ls -aGFh'

# alias aws='docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli:2.11.26'

# Homebrew and pyenv instructions
# export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
# export PATH="/usr/local/opt/sqlite/bin:$PATH"
# export PATH="/usr/local/opt/llvm/bin:$PATH"

# export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"
# export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig:$PKG_CONFIG_PATH"
# export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig:$PKG_CONFIG_PATH"
# export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig:$PKG_CONFIG_PATH"

# export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib -L/usr/local/opt/readline/lib -L/usr/local/opt/sqlite/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/libffi/lib -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/li"
# export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include -I/usr/local/opt/readline/include -I/usr/local/opt/sqlite/include -I/usr/local/opt/zlib/include -I/usr/local/opt/libffi/include -I/usr/local/opt/llvm/include"

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Go dependency path for Hugo for website management
export PATH=$PATH:/usr/local/go/bin

# Add Visual Studio Code (code)
# export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Set path for Stan.jl
export CMDSTAN_HOME=/Users/zeynepenkavi/.cmdstanr/cmdstan-2.26.0

# Git helpers
alias gitdefault='git rev-parse --abbrev-ref origin/HEAD | sed "s/origin\///"'
alias gitprune='git fetch --all --prune && git branch -v | grep "gone]" | awk "{print \$1}" | xargs git branch -D'
alias gitp='git checkout `gitdefault` && git pull && gitprune'
alias gitb='git rev-parse --abbrev-ref HEAD'

# Get current branch, switch to main, pull, back to branch, rebase
alias gitr='X=`gitb`; gitp && git checkout $X && git rebase `gitdefault`'
# Push new branch to origin under the same name
alias gitpb='X=`gitb`; git push -u origin $X'
alias gitpu='gitpb'
alias gti='git'
alias cdroot='cd `git rev-parse --show-toplevel`'
alias gitsetdefault='X=`gitb`; git update-ref --no-deref -d refs/remotes/origin/HEAD && git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/$X'