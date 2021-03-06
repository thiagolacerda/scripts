# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#source ~/.git-completion.sh
source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;78m\]\u@\h: \[\033[38;5;79m\]\W $(__git_ps1 "(%s)")\$\[\033[0m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w $(__git_ps1 "(%s)")\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -lha'
alias vi='vim'
alias gcc-m32='gcc -m32'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Variables
export CLICOLOR="auto"
export EDITOR=vim
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export PATH=$PATH:~/.bin
export NODE_PATH=/usr/lib/node_modules

function setWebKit() {
    PORT="nix"
    TYPE="Release"
    if [[ "$1" != "" ]]
    then
        PORT=${1}
    fi
    if [[ "$2" != "" ]]
    then
        TYPE="$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}"
    fi

    BUILDDIR=/home/thiagolacerda/projects/webkit/${PORT}build
    INSTALLDIR=/home/thiagolacerda/projects/webkit/${PORT}install

    echo "setting environment for WebKit ${PORT}"
    export WEBKIT_OUTPUTDIR=${BUILDDIR}
    export WEBKIT_INSTALLDIR=${INSTALLDIR}
    export PATH=/usr/lib/ccache/bin:/home/thiagolacerda/.bin/python:${PATH}
    export LD_LIBRARY_PATH=${WEBKIT_INSTALLDIR}/lib:${WEBKIT_OUTPUTDIR}/Dependencies/Root/lib64
    export PKG_CONFIG_PATH=${WEBKIT_INSTALLDIR}/lib/pkgconfig/:${WEBKIT_OUTPUTDIR}/Dependencies/Root/lib64/pkgconfig
    if [[ "${PORT}" == "qt" ]]
    then
        export PATH=/home/thiagolacerda/.bin/qt5:${PATH}
    fi
}

function setNS2() {
    export PATH=/home/thiagolacerda/MSc/redes/ns-allinone-2.35/ns-2.35:/home/thiagolacerda/.bin/python:/home/thiagolacerda/MSc/redes/ns-allinone-2.35/bin:/home/thiagolacerda/MSc/redes/ns-allinone-2.35/tcl8.5.10/unix:/home/thiagolacerda/MSc/redes/ns-allinone-2.35/tk8.5.10/unix:$PATH
    export LD_LIBRARY_PATH=/home/thiagolacerda/MSc/redes/ns-allinone-2.35/otcl-1.14:/home/thiagolacerda/MSc/redes/ns-allinone-2.35/lib:$LD_LIBRARY_PATH
    export TCL_LIBRARY_PATH=/home/thiagolacerda/MSc/redes/ns-allinone-2.35/tcl8.5.10/library
}
