dotfiles
========

Configuration files I use.

## Fresh OS Setup

First, install these:
* `ripgrep`
* [`fd`](https://github.com/sharkdp/fd#installation)

1. Install `ripgrep`, `fzf`, `vim-gtk`, `kitty`, `zsh`, and `oh-my-zsh`
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

## Fresh Windows 10 + Ubuntu setup

1. Download the Windows 10 ISO, which can only be obtained by visiting the page from a browser with a *non-Windows* User Agent.
2. Put the ISO on a thumb drive using [Rufus](https://rufus.ie), not the tool from Microsoft. (The latter doesn't work, in my experience.)
3. Install Windows 10, leaving a large chunk of partition space for Ubuntu
4. [Disable Fast Boot](https://www.windowscentral.com/how-disable-windows-10-fast-startup), because otherwise the Ubuntu installer won't offer the "install alongside Windows" option.
5. [*Enable* Secure Boot](https://www.appgeeker.com/recovery/disable-uefi-secure-boot-in-windows-10.html) in the machine's firmware settings if it is not already enabled - this way, the Ubuntu installer will use UEFI mode and try to install a dual boot with Windows. Otherwise it'll try to install in BIOS mode by default, and "install alongside Windows" [won't be an option in the installer](https://ubuntuforums.org/showthread.php?t=2309806).
6. Download an Ubuntu ISO and put it on a thumb drive.
7. Install Ubuntu on the open partition. The installer will hopefully recognize Windows and offer to install alongisde it.
8. If GRUB won't load on boot, try going into the firmware settings and setting the boot order on the hard disk (not just the main boot order, but actually the order of the disk itself - may be hard to find in the menus) and setting "ubuntu" higher priority than "Windows Boot Manager." If that doesn't work, maybe try [boot repair](https://www.howtogeek.com/114884/how-to-repair-grub2-when-ubuntu-wont-boot/). Otherwise, may have to switch between UEFI and non-UEFI at boot time. Another thing to try is to boot to Try Ubuntu and run [`sudo fixparts`](https://askubuntu.com/a/289233) to fix the MBR.
