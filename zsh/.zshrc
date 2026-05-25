eval "$(starship init zsh)"

typeset -U path PATH

path=(
  $HOME/.npm-global/bin
  $HOME/.cargo/bin
  $HOME/go/bin
  $HOME/.local/share/bob/nvim-bin
  $path
)
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH

alias vim='nvim'
alias ls='ls --color=auto'
alias l='ls'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias llah='ls -lah'

