if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr -a nixRF 'sudo nixos-rebuild switch --flake .#(uname -n)'

set fish_greeting
set TERM "xterm-256color"
set FISH_CLIPBOARD_CMD "cat"

set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

setenv LESS_TERMCAP_mb \e'[01;31m'
setenv LESS_TERMCAP_md \e'[01;38;5;74m'
setenv LESS_TERMCAP_me \e'[0m'
setenv LESS_TERMCAP_se \e'[0m'
setenv LESS_TERMCAP_so \e'[38;5;246m'
setenv LESS_TERMCAP_ue \e'[0m'
setenv LESS_TERMCAP_us \e'[04;38;5;146m'

function fish_prompt
	set_color yellow
	echo -n (whoami)
    set_color red
	echo -n ':'
	if [ $PWD != $HOME ]
		set_color green
		echo -n (basename $PWD)
	end
	set_color brpurple
	printf '%s ' (__fish_git_prompt)
	set_color red
	echo -n '# '
	set_color normal
end

function __delete-line
   commandline -f beginning-of-line
   commandline -f kill-line
end

function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# Custom binds
bind \cg cancel
bind \cH backward-kill-word
bind \cw __delete-line
bind ! __history_previous_command
bind '$' __history_previous_command_arguments

# Alias
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'


# bind \t accept-autosuggestion
# bind \t\t complete
