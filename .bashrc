set +h

# expand aliases in non-interactive shells
shopt -s expand_aliases


# prompt
source ~/bin/git-prompt.bash
function minutes_since_last_commit {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}

git_prompt() {
    local g="$(__gitdir)"
    if [ -n "$g" ]; then
        local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
        if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
            local COLOR=${RED}
        elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
            local COLOR=${YELLOW}
        else
            local COLOR=${GREEN}
        fi
        local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m${NORMAL}"
        # The __git_ps1 function inserts the current git branch where %s is
        local GIT_PROMPT=`__git_ps1 "(%s|${SINCE_LAST_COMMIT})"`
        echo ${GIT_PROMPT}
    fi
}
export PS1="failbot:\W\[\033[32m\]\$(git_prompt)\[\033[00m\] $ "

# editor
export EDITOR=vim

# history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

### paths
export PATH="/usr/local/sbin:/usr/local/bin:$HOME/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="/usr/local/opt:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="~/bin:$PATH"

# aliases
alias sb="source ~/.bash_profile"
alias vimrc="vim ~/.vimrc"
alias bashrc="vim ~/.bashrc"
alias ls="ls -lG"
alias mkdir="mkdir -pv"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias phpunit="./vendor/bin/phpunit"
alias ag="ag --path-to-ignore ~/.ignore"
alias b="./build.sh"
alias python="python3"

# git autocomplete
# https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# functions
mkcd() {
    mkdir -pv $1
    cd $1
}

r() {
   curDir="${PWD##*/}"

   if [ ! -d "build" ]; then
       echo "build is not a directory"
       return -1
   fi

   ./build/$curDir "$@"
}

# work
alias bup="cd ~/work/breeze && dinghy up || true && docker-compose up -d"
alias zup="cd ~/work/zephyr/api && php artisan serve"
alias rup="cd ~/work/zephyr/ui && yarn start"

export DOCKER_HOST=tcp://192.168.64.7:2376
export DOCKER_CERT_PATH=/Users/spangler/.docker/machine/machines/dinghy
export DOCKER_TLS_VERIFY=1
export DOCKER_MACHINE_NAME=dinghy
