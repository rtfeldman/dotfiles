dotfiles
========

Configuration files I use.

## Fresh Neovim Setup

1. brew install ag neovim/neovim/neovim
2. Install vim-plug
3. Make sure Python 2.7.x is installed, for the YouCompleteMe plugin
4. pip2 install --user neovim
5. `git clone git@github.com:rtfeldman/dotfiles.git`
6. `cd dotfiles`
7. `ln -fs $(pwd)/init.vim ~/.config/nvim/init.vim`
8. `brew install ctags`
9. `gem install CoffeeTags`
10. start nvim!

## Fresh Sublime Text 3 Setup

```bash
defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false
ln -fs ~/dotfiles/subl/Installed\ Packages/ ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/
ln -fs ~/dotfiles/subl/Packages/User/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
ln -fs ~/dotfiles/subl/Packages/User/Default\ \(OSX\).sublime-keymap ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap
ln -fs ~/dotfiles/subl/Packages/User/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings
ln -fs /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
```

## Fresh Emacs Setup

1. Install Emacs
2. `ln -s ~/dotfiles/init.el ~/.emacs.d/init.el`
3. `ln -s ~/dotfiles/emacs-submodules/ ~/.emacs.d/submodules`

## Fresh Vim Setup

1. Install Vim
2. `mkdir -p ~/.vim/tmp`
3. Install pathogen: https://github.com/tpope/vim-pathogen
4. `git clone git@github.com:rtfeldman/dotfiles.git`
5. `cd dotfiles`
6. `git submodule init && git submodule update`
7. `ln -fs path/to/dotfiles/.inputrc ~/.inputrc`
7. `ln -fs path/to/dotfiles/.vimrc ~/.vimrc`
8. `ln -fs path/to/dotfiles/.gvimrc ~/.gvimrc`
9. `ln -fs path/to/dotfiles/vim-bundles ~/.vim/bundle`
10. `brew install ctags`
11. `gem install CoffeeTags`
12. `cd vim-bundles/command-t`
13. `rake make`
14. start vim!

## OS X Config

```bash
ln -fs ~/dotfiles/.vimrc ~/.vimrc
ln -fs ~/dotfiles/.gitrc ~/.vimrc
```

Install git and bash completion:

```bash
brew install git bash-completion
brew install fzf
```

...then add the following to `~/.bash-profile` to activate bash completion:

```bash
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
```

Install iTerm2, then from within this repo's directory:

1. `open nvim.itermcolors`
2. Select the 'hybrid' color palette in iTerm
3. Add a custom modifier for Cmd+S that has it send
hex code 0x13 (Ctrl-S, which nvim will then use to Save).
4. Do the same for Cmd+O and 0x10 (Ctrl-P).
