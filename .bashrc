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


# Define a function to run tmux-sessionizer
function run_tmux_sessionizer() {
    bash ~/.local/scripts/tmux-sessionizer
}

# Bind Ctrl+Shift+F to run_tmux_sessionizer
bind -x '"\C-f": run_tmux_sessionizer'

# Cargo Binaries
CARGO_HOME=$HOME/.cargo
export CARGO_HOME
export PATH=$PATH:$CARGO_HOME/bin

# Personal Scripts
export PATH=$PATH:$HOME/.local/scripts

# TMUX specifc PS
# Check if in a TMUX session
if [[ -n "$TMUX" ]]; then
    # Customize the prompt when in TMUX
    PS1="> \[\e[38;5;32m\]\W\[\e[91m\]"

    # Check if in a Git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        # If in a Git repository, add the Git branch
    #  PS1+=" git:(\[\e[1;32m\]\$(git branch 2>/dev/null | grep \* | cut -d ' ' -f2)\[\033[0m\]) $ "
    PS1+=" \[\e[91m\]git\[\e[0m\]:(\[\e[1;32m\]\$(git branch 2>/dev/null | grep \* | cut -d ' ' -f2)\[\e[0m\]) $ "
    else
        PS1+=" \[\e[0m\]$ "
    fi
else
    # Default prompt when not in TMUX
    PS1="> \[\e[38;5;32m\]\W \[\e[0m\]$ "
fi

