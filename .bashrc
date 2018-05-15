# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#source ~/.git-completion.sh
#source /usr/share/git/completion/git-completion.bash
#source /usr/share/git/completion/git-prompt.sh
source /usr/local/etc/bash_completion
source /usr/local/opt/bash-git-prompt/share/gitprompt.sh
#source /opt/local/etc/bash_completion
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
export EDITOR=nvim
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export PATH=$PATH:~/.bin
export NODE_PATH=/usr/lib/node_modules

# perforce stuff
#export P4USER=
#export P4PORT=
#export P4EDITOR=nvim
#export P4DIFF=colordiff
#export P4CONFIG=.p4config
#export P4MERGE=p4merge

# tableau unit tests
export LANG=en_US.UTF-8

# homebrew
export HOMEBREW_GITHUB_API_TOKEN=e52afde95a2f8414ddde78b899dda2c3d24a2709

# ccache
#if [ -d /usr/local/opt/ccache/libexec/ ]; then
#    export PATH=/usr/local/opt/ccache/libexec:$PATH
#fi

function workspace() {
    P4CLIENT=`basename "$1"`
    WORKDIR=$1
    TICKET=`p4 login -s`
    echo $TICKET
    if ! [[ "$TICKET" =~ "User ${P4USER} ticket expires in" ]]
    then
        p4 login
    fi

    if [ ! -d "${WORKDIR}" ]
    then
        mkdir ${WORKDIR}
        echo "P4CLIENT=$P4CLIENT" > ${WORKDIR}/.p4config
    fi
    cd ${WORKDIR}
}

function generate_ctags() {
    CURRENT_DIR=`pwd`
    DIR_TAIL=`basename ${CURRENT_DIR}`
    TAGS_DIR="$HOME/.tags/${DIR_TAIL}"
    echo $TAGS_DIR
    if [ ! -d "${TAGS_DIR}" ]
    then
        mkdir "$TAGS_DIR"
    fi
    cd $TAGS_DIR
    find $CURRENT_DIR -name \*.h -print -o -name \*.cpp -print | ctags --fields=+l --extra=+f -f $TAGS_DIR/tags -L - $CURRENT_DIR
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
