dotfiles
========

Configuration files I use.

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
7. `ln -s path/to/dotfiles/.inputrc ~/.inputrc`
7. `ln -s path/to/dotfiles/.vimrc ~/.vimrc`
8. `ln -s path/to/dotfiles/.gvimrc ~/.gvimrc`
9. `ln -s path/to/dotfiles/vim-bundles ~/.vim/bundle`
10. `brew install ctags`
11. `gem install CoffeeTags`
12. `cd vim-bundles/command-t`
13. `rake make`
14. start vim!

## Fresh Sublime Text 3 Setup

1. Replace `path/to/sublime/Packages/User/Package\ Control.sublime-settings` with `ln -s ~/dotfiles/subl/Packages/User/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings`
2. Replace `path/to/sublime/Packages/User/Default\ \(OSX\).sublime-keymap` with `ln -s ~/dotfiles/subl/Packages/User/Default\ \(OSX\).sublime-keymap ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap`
3. Replace `path/to/sublime/Packages/User/Preferences.sublime-settings` with `ln -s ~/dotfiles/subl/Packages/User/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings`
4. Replace `path/to/sublime/Installed\ Packages` with a symlink to `path/to/dotfiles/subl/Installed\ Packages`
1. (OS X only) run this in the terminal:

```bash
defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false
```
