# Path to your oh-my-zsh installation.
export ZSH="/Users/leo/.oh-my-zsh"
export editor='vim'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="avit"
# POWERLEVEL9K_DISABLE_RPROMPT=true
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir virtualenv)

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    # vi-mode
)

setopt IGNORE_EOF # Stops ctl-D from closing terminal

source $ZSH/oh-my-zsh.sh

# User configuration
# This makes less display search results in the middle of the screen (instead of the top)
export LESS="-j.5 -R"

export BAT_THEME="gruvbox"

# To match with vim
bindkey '^b' backward-delete-word

# alias pip="pip3.11"
# alias python="python3.11"

export PATH=$PATH:/Users/leo/.local/bin

