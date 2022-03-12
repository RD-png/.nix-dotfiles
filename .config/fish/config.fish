if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr -a nixRF 'sudo nixos-rebuild switch --flake .#(uname -n)'

set fish_greeting
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
