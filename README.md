dotfiles
========

Configuration files I use.

## Fresh Vim Setup

1. Install Vim
2. `mkdir -p ~/.vim/tmp`
3. Install pathogen: https://github.com/tpope/vim-pathogen
4. `git clone git@github.com:rtfeldman/dotfiles.git`
5. `cd dotfiles`
6. `git submodule init && git submodule update`
7. `ln -s path/to/dotfiles/.inputrc ~/.inputrc`
7. `ln -s path/to/dotfiles/.vimrc ~/.vimrc`
8. `ln -s path/to/dotfiles/.gvimrc ~/.gvimrc`
9. `ln -s path/to/dotfiles/vim-bundles ~/.vim/bundle`
10. `brew install ctags`
11. `gem install CoffeeTags`
12. `cd vim-bundles/command-t`
13. `rake make`
14. start vim!

