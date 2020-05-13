dotfiles
========

Configuration files I use.

## Fresh OS Setup

1. Install `ripgrep`, `fzf`, `vim`, `kitty`, `zsh`, and `oh-my-zsh`
2. Install vim-plug
3. `mkdir -p ~/.vim/files/info/`
4. `git clone git@github.com:rtfeldman/dotfiles.git`
5. `cd dotfiles`
6. `ln -fs $(pwd)/.gitconfig ~/.gitconfig`
7. `ln -fs $(pwd)/.zshrc ~/.zshrc`
8. `ln -fs $(pwd)/.vimrc ~/.config/.vimrc`
9. `ln -fs $(pwd)/.config/kitty ~/.config/kitty`
10. `ln -fs ~/.config/kitty/themes/AtomOneDark.conf ~/.config/kitty/theme.conf`
11. `echo "font_size 16.0" > ~/.config/kitty/kitty-local.conf`
12. Start vim and run `:PlugInstall`

## Fresh Linux setup

1. Get [color emoji](https://victor.kropp.name/blog/emoji-on-linux/)
