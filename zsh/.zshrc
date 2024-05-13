export ZSH=$HOME/.oh-my-zsh
export ZSH_PLUGINS=$ZSH/custom/plugins
export ZSH_SCRIPTS=$HOME/.zshscripts
export EDITOR="vim"

export ZSH_CONFIGS=$HOME/.config/zsh


plugins=(git brew colorize common-aliases zsh-interactive-cd)
source $ZSH/oh-my-zsh.sh

source $ZSH_CONFIGS/aliases.sh
source $ZSH_CONFIGS/paths.sh

