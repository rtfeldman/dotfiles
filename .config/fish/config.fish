set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.npm-global/bin $PATH

alias g="git"
alias gst="git status"
alias gco="git checkout"
alias gc="git commit"
alias ga="git add"
alias gd="git diff"
alias gl="git log"
alias gfa="git fetch --all"
alias gpr="git pull --rebase"
alias grh="git reset --hard"

alias npmtest='npm test --ignore-scripts=false'
alias npmrun='npm run --ignore-scripts=false'

alias pbcopy="xclip -selection c"

# --files: List files that would be searched but do not search
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
