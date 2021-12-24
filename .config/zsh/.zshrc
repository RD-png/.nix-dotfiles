# Created by newuser for 5.8
autoload -U colors && colors
PS1="%B%{$fg[magenta]%}%n%{$fg[blue]%} @ %{$fg[yellow]%}%M %{$fg[green]%}%~ %{$reset_color%}#%b "
stty stop undef
