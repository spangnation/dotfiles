#!/bin/sh

set -e

# add dot files
cd ~/
git clone https://github.com/failbottt/dotfiles.git .

# faster key input
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# switch to bash
chsh -s /bin/bash

# Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 

# vim things
mkdir -p ~/.vim/bundle
# because if you try to clone into a non-empty dir git complains
cd ~/.vim/bundle
git clone https://github.com/rking/ag.vim ~/.vim/bundle/ag.vim
git clone https://github.com/wincent/command-t ~/.vim/bundle/commandt
git clone https://github.com/tpope/vim-commentary ~/.vim/bundle/vim-commentary
git clone https://github.com/MaxMEllon/vim-jsx-pretty ~/.vim/bundle/vim-js-pretty
git clone https://github.com/tpope/vim-repeat ~/.vim/bundle/vim-repeat
git clone https://github.com/tpope/vim-surround ~/.vim/bundle/vim-surround
git clone https://github.com/janko/vim-test ~/.vim/bundle/vim-test
git clone https://github.com/tpope/vim-vinegar ~/.vim/bundle/vim-vinegar
git clone https://github.com/editorconfig/editorconfig-vim ~/.vim/bundle/editor-config
cd ~/

# compile command-t with same version of ruby vim is compiled with
cd ~/.vim/bundle/command-t
rake clean && rake make
cd ~/

# cli tools
brew install the_silver_searcher
brew install chrome-cli
brew install ctags
brew install composer
brew install yarn
