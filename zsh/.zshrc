export ZSH=$HOME/.oh-my-zsh
export ZSH_PLUGINS=$ZSH/custom/plugins
export ZSH_SCRIPTS=$HOME/.zshscripts
export EDITOR="vim"

export ZSH_CONFIGS=$HOME/.config/zsh


plugins=(git brew colorize common-aliases zsh-interactive-cd)
source $ZSH/oh-my-zsh.sh

source $ZSH_CONFIGS/aliases.sh
source $ZSH_CONFIGS/paths.sh

# bun completions
[ -s "/Users/musyilmaz/.bun/_bun" ] && source "/Users/musyilmaz/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

#. "$HOME/.local/bin/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/musyilmaz/.lmstudio/bin"
# End of LM Studio CLI section

export PATH="$HOME/.local/bin:$PATH"

# GitHub MCP server token (sourced from gh CLI auth)
export GITHUB_PERSONAL_ACCESS_TOKEN="$(gh auth token 2>/dev/null)"

# Claude Code accounts: each gets its own config dir (settings, history, login)
alias claude-work='CLAUDE_CONFIG_DIR="$HOME/.claude-work" claude'
alias claude-my='CLAUDE_CONFIG_DIR="$HOME/.claude-my" claude'

# Machine-local overrides and secrets. This repo is public, so credentials live
# here instead of in tracked files; create ~/.zshrc.local per device.
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
