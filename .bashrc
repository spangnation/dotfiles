set +h

# expand aliases in non-interactive shells
shopt -s expand_aliases

# prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="failbot:\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# editor
export EDITOR=vim

# history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
export HISTTIMEFORMAT="%d/%m/%y %T "

### path
export PATH="/usr/local/sbin:/usr/local/bin:$HOME/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="/usr/local/opt:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"

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

notes() {
    if [ $1 ]
    then
        vim ~/notes/$1.txt
    else
        vim ~/notes
    fi
}

# work
alias bup="cd ~/work/breeze && dinghy up || true && docker-compose up -d"
alias zup="cd ~/work/zephyr/api && php artisan serve"
alias rup="cd ~/work/zephyr/ui && yarn start"

export DOCKER_HOST=tcp://192.168.64.7:2376
export DOCKER_CERT_PATH=/Users/spangler/.docker/machine/machines/dinghy
export DOCKER_TLS_VERIFY=1
export DOCKER_MACHINE_NAME=dinghy
