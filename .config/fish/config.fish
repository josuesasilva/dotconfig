#
# Initial setup:
#
# brew install fish
#
# Install fisher
# curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
#
# Add plugins
#
# fisher install PatrickF1/fzf.fish
# fisher install jorgebucaran/nvm.fish
# fisher install rbenv/fish-rbenv
#
# Oh my fish
#
# curl -L https://get.oh-my.fish | fish
#
# Oh my fish plugins
#
# omf install nvm
#

# Poetry
set -gx PATH /Users/josue/.local/bin $PATH

# Homebrew
set -gx PATH /opt/homebrew/bin $PATH

# For compilers to find openjdk
set --export CPPFLAGS -I/opt/homebrew/opt/openjdk/include

# Android
set --export ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $ANDROID_HOME/tools $PATH
set -gx PATH $ANDROID_HOME/tools/bin $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/emulator $PATH

# Java
set --export JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# Ruby
. (rbenv init -|psub)

# NVM
set -gx NVM_DIR $HOME/.nvm

# Editor
set -U EDITOR nvim

# Alias
alias vim="nvim"
alias brew="env PATH=(string replace (pyenv root)/shims '' \"\$PATH\") brew"
alias nvimc="nvim $HOME/.config/nvim/init.lua"
alias fishc="nvim $HOME/.config/fish/config.fish; source $HOME/.config/fish/config.fish"
alias refresh-fish="source $HOME/.config/fish/config.fish"
alias weztermc="nvim $HOME/.config/wezterm/wezterm.lua"

alias xcc="sh $HOME/scripts/select-xcode-current.sh"
alias xco="sh $HOME/scripts/select-xcode-old.sh"

alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Env
source $HOME/.secrets/env-secrets.fish
