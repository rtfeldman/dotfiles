# oh-my-zsh config (runs before everything else)

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode fzf)

source $ZSH/oh-my-zsh.sh

# User configuration

# Rust crates
export PATH="$HOME/.cargo/bin:$PATH"

export EDITOR='vim'

alias npmtest='npm test --ignore-scripts=false'
alias npmrun='npm run --ignore-scripts=false'

if [ -x "$(command -v direnv)" ]; then
  eval "$(direnv hook zsh)"
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'

# Pass through Ctrl-S to applications (e.g.vim)
stty -ixon
