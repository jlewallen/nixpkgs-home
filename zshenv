# Path

export PATH=$PATH:$HOME/tools/nanopb/generator
export PATH=$PATH:$HOME/tools/cmake/bin
export PATH=$PATH:$HOME/tools/node/bin
export PATH=$PATH:$HOME/tools/gitkraken
export PATH=$PATH:$HOME/tools/flutter/bin
export PATH=$PATH:$HOME/tools/p4merge/bin
export PATH=$PATH:$HOME/tools/jlink
export PATH=$PATH:$HOME/tools/protoc/bin
export PATH=$PATH:$HOME/tools/vscode/bin

export PATH=$PATH:$HOME/go/bin

export PATH=$PATH:$HOME/sync/bin
export PATH=$PATH:$HOME/tools/bin

export PATH=$PATH:$HOME/.pub-cache/bin
export PATH=$PATH:$HOME/.nix-profile/bin

# WARNING DO NOT COPY Long been considering changing how I do this.
export PATH=$PATH:node_modules/.bin

# OSX Check 
if [ -d /Applications/CMake.app/Contents/bin ]; then
	export PATH=$PATH:/Applications/CMake.app/Contents/bin
fi

# This is me.
export EDITOR=vim
export GIT_EDITOR=vim

# Conditionally setup go environment.
if [ -d ~/tools/go ]; then
	export GOPATH=~/go
	export GOROOT=~/tools/go
	export PATH=$PATH:$GOROOT/bin
fi

# Android
if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
	export ANDROID_HOME=$HOME/tools/android-sdk
else
	export ANDROID_HOME=$HOME/tools/android-sdk
fi

if [ -d $ANDROID_HOME ]; then
	export PATH=$PATH:$ANDROID_HOME/tools
	export PATH=$PATH:$ANDROID_HOME/tools/bin
	export PATH=$PATH:$ANDROID_HOME/platform-tools
fi

# Other miscellaneous things.
export MAKEFLAGS=--no-print-directory

# Emacs, back in the day.
export EMACSCLIENT=emacsclient
if [ -f /Applications/Emacs.app/Contents/MacOS/bin/emacsclient ]; then
	export EMACSCLIENT=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
fi
if [ -f ~/tools/emacs/installed/bin/emacsclient ]; then
	export EMACSCLIENT=~/tools/emacs/installed/bin/emacsclient
fi
alias ecc="$EMACSCLIENT -n -c"
alias ec="i3-msg workspace number 1 ; $EMACSCLIENT -n"

# Spotify resolution.
if [ "$(hostname 2> /dev/null)" = "JACOB-LAPTOP" ]; then
    alias spotify="/usr/bin/spotify --force-device-scale-factor=1.5"
fi

# Alias tools if we find them.
if [ -x "$(command -v bat)" ]; then
    alias cat="bat"
fi

if [ -x "$(command -v batcat)" ]; then
    alias cat="batcat"
fi

# Aliases
alias c="clear"
alias p="python3"
alias mv="mv -n"
alias warn="notify-send -u critical"
alias flag="notify-send -u critical DONE"
alias sdone="spd-say done"
alias cgrep="grep --color=always"
alias stripcolors="sed -r 's/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g'"
alias ips="ip --brief addr"

# TODO Helpers
TODO="$HOME/sync/notes/TODO"

function td() {
	maybe_where=$1
	where=$TODO
	if [ "$maybe_where" != "" ]; then
		where="$TODO/$1*"
	fi
	case $PWD/ in
	$TODO/*) popd      ;;
	*) pushd ${~where} ;;  # zsh specific wildcard expansion
	esac
}

alias vtd="(cd $TODO && find . -not -path './.git*' -type f -printf '%T@ %p\n' | sort -n | cut -d' ' -f2-)"

# UNIX time helper.
function ux() {
	if [ -z "$1" ]; then
		TZ="UTC" date "+%s"
	else
		TZ="UTC" date -d @$1
	fi
}

# Private environment, not in git.
if [ -f ~/.zshenv.private.sh ]; then
    source ~/.zshenv.private.sh
fi

# Rust
. "$HOME/.cargo/env"

# Random bits.

# Change default terminal emulator.
# sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ~/tools/bin/alacritty 50

# For some reason these don't work very well when set inside here, so check the
# oh-my-zsh files.
#
# ~/.oh-my-zsh/lib/directories.zsh
# ~/.oh-my-zsh/lib/history.zsh
#
unsetopt auto_pushd
setopt no_share_history
unsetopt share_history

# eof
