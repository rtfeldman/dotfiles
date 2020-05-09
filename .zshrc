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
alias cls='tput reset' # https://askubuntu.com/a/25079

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
