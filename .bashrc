# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc


# Bind Ctrl+Shift+F to tmux_sessionizer
bind -x '"\C-f": tmux-sessionizer'

# Bind Ctrl+` to tmux_sessionizer for opening dot files
bind -x '"\C-`": tmux-sessionizer ~/.dotfiles'

# Cargo Binaries
CARGO_HOME=$HOME/.cargo
export CARGO_HOME
export PATH=$PATH:$CARGO_HOME/bin

# Personal Scripts
export PATH=$PATH:$HOME/.local/scripts

# Flutter Sdk
export PATH=$PATH:$HOME/tools/flutter/bin

#SDK exporting
export ANDROID_HOME=$HOME/tools/Android/Sdk

#Exporting tools
export PATH=$PATH:$HOME/tools/Android/Sdk/platform-tools


# TMUX specifc PS
# Check if in a TMUX session
if [[ -n "$TMUX" ]]; then
    # Customize the prompt when in TMUX
    PS1="> \[\e[38;5;32m\]\W\[\e[91m\]"

    # Check if in a Git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        # If in a Git repository, add the Git branch
        PS1+=" \[\e[91m\]git\[\e[0m\]:(\[\e[1;32m\]\$(git branch 2>/dev/null | grep \* | cut -d ' ' -f2)\[\e[0m\]) $ "
    else
        PS1+=" \[\e[0m\]$ "
    fi
else
    # Default prompt when not in TMUX
    PS1="> \[\e[38;5;32m\]\W \[\e[0m\]$ "
fi

export GOPATH=$HOME/go

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
