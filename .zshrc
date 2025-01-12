# Load the antigen plugin manager
source "$HOME/.config/zsh/antigen.zsh"

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

# ADD brew to path
PATH="$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin"

# LOAD ALIASES FROM ALIASRC
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

# initialize preferred mamba environment
eval "$(starship init zsh)"

# activate zoxide: accelerated cd 
eval "$(zoxide init zsh)"

# activate atuin: shell history db
eval "$(atuin init zsh)"
