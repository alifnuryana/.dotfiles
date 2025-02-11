if uwsm check may-start; then
  exec uwsm start hyprland.desktop
fi

source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle git
antigen bundle fzf
antigen bundle npm
antigen bundle node
antigen bundle nekofar/zsh-pnpm
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle fdellwing/zsh-bat

antigen apply

eval "$(starship init zsh)"

# Aliases
alias ls='eza --icons --color=auto'

# PNPM Global Path
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac