# NOTE: I'm trying to stop using oh-my-zsh and instead set up terminal colors,
# git aliases, and fzf (and maybe vim keybindings) via Nix and .zshrc instead.

####### begin oh-my-zsh #######

# oh-my-zsh config (runs before everything else)

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode fzf)

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh

####### end oh-my-zsh #######

# Tell gpg how to prompt for password: https://github.com/keybase/keybase-issues/issues/2798
export GPG_TTY=$(tty)

# Initialize zsh's built-in autocomplete (which ships with git autocomplete)
# https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Initialization
autoload -Uz compinit && compinit

# ll
alias ll='ls -lahF --color=auto'

# Git aliases
# https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet

alias -g g="git"
alias -g gd="git diff"
alias -g ga="git add"
alias -g gb="git branch"
alias -g gc="git commit -v"
alias -g gc!="git commit -v --amend"
alias -g gco="git checkout"
alias -g gca="git commit --amend"
alias -g gcp="git cherry-pick"
alias -g gfa="git fetch --all"
alias -g gst="git status"
alias -g grh="git reset --hard"
alias -g gpf="git push --force-with-lease"
alias -g gp="git push"

# Rust crates
export PATH="$HOME/.cargo/bin:$PATH"

# pip3 binaries
export PATH="$HOME/.local/bin:$PATH"

# LLVM
export LLVM_SYS_100_PREFIX="$HOME/llvm"

export EDITOR='vim'

alias npmtest='npm test --ignore-scripts=false'
alias npmrun='npm run --ignore-scripts=false'
alias cls='tput reset' # https://askubuntu.com/a/25079
alias ctrlc='xclip -selection c'
alias ctrlv='xclip -selection c -o'

if [ -x "$(command -v direnv)" ]; then
  eval "$(direnv hook zsh)"
fi

# --files: List files that would be searched but do not search
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Pass through Ctrl-S to applications (e.g.vim)
stty -ixon

# Install FZF completions, if available
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export NIX_PATH=darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

# Add colors to Terminal
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
