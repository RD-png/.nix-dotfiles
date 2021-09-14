# zsh config
cd "/root/"
neofetch
autoload -U colors && colors
PS1="%B%{$fg[red]%}%n %B%{$fg[yellow]%}@ %B%{$fg[green]%}%~%{$reset_color%} %B%{$fg[magenta]%}>>%b "
setopt interactive_comments
setopt autocd # cd into dirs without prefix
stty stop undef

# History
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

# Import aliasrc
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"


# Access to global npm packages
export PATH=~/.config/npm/bin:$PATH

# Completion
autoload -U compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Show dot / hidden files
_comp_options+=(globdots)
eval "$(direnv hook zsh)"
