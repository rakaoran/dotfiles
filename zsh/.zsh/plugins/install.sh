#!/usr/bin/env bash

mkdir -p ~/.zsh/plugins

if [ ! -d ~/.zsh/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
fi

if [ ! -d ~/.zsh/plugins/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
fi
