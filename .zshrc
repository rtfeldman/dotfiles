# Nix (this normally goes in /etc/zshrc but macOS overrides that on some system updates -
# see https://gist.github.com/meeech/0b97a86f235d10bc4e2a1116eec38e7e#nix-setup-will-modify-your-etczshrc-when-os-x-updates-it-will-sometimes-restore-the-original-etczshrc
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# End Nix
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
alias -g gp="git push -u origin HEAD"

# Rust crates
export PATH="$HOME/.cargo/bin:$PATH"

# pip3 binaries
export PATH="$HOME/.local/bin:$PATH"

# npm
export PATH="$HOME/.npm-global/bin:$PATH"

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

# Add colors to Terminal
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Ruby
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.1.0/bin:$PATH"

# Roc compiler
export PATH="$HOME/code/roc/target/release:$PATH"

# Enable vi mode in zsh
bindkey -v

# Find and set branch name var if in git repository.
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo ''%F{yellow}$branch%f''
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

# Set the prompt
export PROMPT='%F{cyan}%0~%f $(git_branch_name)$ '
