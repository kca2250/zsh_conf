# zshファイルの読み込み
export ZDOTDIR="$HOME/.config/zsh"
source $ZDOTDIR/.antidote/antidote.zsh
source $ZDOTDIR/.zsh_plugins.zsh

# パスとか色とか alias
export EDITOR=nvim

# alias
alias ls='eza'
alias cat='bat'
alias ll='eza -la'

# vcs info
autoload -Uz vcs_info
precmd() { vcs_info }

setopt prompt_subst
PROMPT='%F{cyan}%n@%m%f %F{green}%~%f ${vcs_info_msg_0_} %# '
