# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.node_modules/bin:$PATH

# npm global modules
export PATH=$HOME/.npm-global/bin:$PATH

# Rust crates
export PATH="$HOME/.cargo/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# For the fzf oh-my-zsh plugin
export FZF_BASE=$HOME/.fzf

# --files: List files that would be searched but do not search
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode fzf)

source $ZSH/oh-my-zsh.sh

alias npmtest='npm test --ignore-scripts=false'
alias npmrun='npm run --ignore-scripts=false'
alias elmdocs='elm-make --docs=${HOME}/Downloads/documentation.json'
source $HOME/.aws/.zshrc

# alias pbcopy="xclip -selection c"

source $HOME/.nix-profile/etc/profile.d/nix.sh

eval "$(direnv hook zsh)"

# Pass through Ctrl-S to programs (e.g. vim)
stty -ixon
