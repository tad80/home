# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.

stty stop undef

eval `dircolors -b /etc/DIR_COLORS`
alias ls='ls -CF'
alias ll='ls -AlFh --show-control-chars --color=always'
alias la='ls -CFal'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias sc='screen'
alias ps='ps --sort=start_time'

umask 022
if [[ ${USER} == "root" ]]; then
	export PS1='\[\033[01;31m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
else
	export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
	export PATH=$PATH:/sbin:/usr/sbin
	export MANPATH=$MANPATH:/usr/share/postgresql-8.4/man:/usr/share/postgresql-8.2/man
fi

export PS2='%'
export PAGER="/usr/bin/lv -c"
export LESS=-R
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export EDITOR=vim
export TERM=rxvt
export HISTSIZE=100000

[ -n "$SSH_CLIENT" ] && {

  export LANG="ja_JP.UTF-8"
  export LC_ALL="ja_JP.UTF-8"
  export LC_MESSAGES="ja_JP.UTF-8"
  export JLESSCHARSET=japanese

  agent="$HOME/tmp/ssh-agent-$USER"
  if [ -S "$SSH_AUTH_SOCK" ]; then
          case $SSH_AUTH_SOCK in
                  /tmp/*/agent.[0-9]*)
                  ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
          esac
  elif [ -S $agent ]; then
          export SSH_AUTH_SOCK=$agent
  else
          echo "no ssh-agent"
  fi

}
