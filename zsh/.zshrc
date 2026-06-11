eval "$(starship init zsh)"

source ~/.antidote/antidote.zsh
antidote load

typeset -U path PATH

export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH
export EDITOR=nvim

path=(
  $HOME/.npm-global/bin
  $HOME/ctf/bin
  $HOME/.cargo/bin
  $HOME/go/bin
  $HOME/manbin/bin
  $HOME/.local/share/bob/nvim-bin
  $ANDROID_HOME/cmdline-tools/latest/bin
  $ANDROID_HOME/platform-tools
  $ANDROID_HOME/build-tools/36.0.0
  $path
)

alias vim='nvim'
alias ls='ls --color=auto'
alias l='ls'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias llah='ls -lah'

