# Prompt configuration
autoload -Uz colors && colors
setopt PROMPT_SUBST
source ~/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWCOLORHINTS=true

precmd() {
	local LEFT_PROMPT='%n@%m:%~'
	local COLORED_LEFT_PROMPT='%{$fg_bold[green]%}%n@%m%{$reset_color%}:%{$fg_no_bold[blue]%}%~%{$reset_color%}'
	local COLORED_RIGHT_PROMPT='%{$fg_no_bold[white]%}[%j] %{$fg_bold[black]%}| %*%(?..%{$fg_no_bold[red]%} %?⤶)%{$reset_color%}'
	local NEWLINE=$'\n'
	local LAST_EXIT_STATUS=$?

	# Adds necessary padding to right align [jobs] | date (last exit status)
	right_align() {
		local PADDING=''
		local PADDING_CHAR=' '

		LEFT_PROMPT_SIZE="${#${(%)LEFT_PROMPT}}"
		RIGHT_PROMPT_SIZE="${#${(%)RIGHT_PROMPT}}"
		(( PADDING_SIZE=${COLUMNS} - (${RIGHT_PROMPT_SIZE} + ${LEFT_PROMPT_SIZE} + 6) ))
		for (( i = 0; i < ${PADDING_SIZE}; i++ ));
		do PADDING=${PADDING}${PADDING_CHAR};
		done
		echo $PADDING
	}

	if [[ $LAST_EXIT_STATUS -eq 0 ]]; then
		RIGHT_PROMPT='[%j] | %*'
	elif [[ $LAST_EXIT_STATUS -ge 100 ]]; then
		RIGHT_PROMPT='[%j] | %* %?⤶  '
	else
		RIGHT_PROMPT='[%j] | %* %?⤶ '
	fi
	__git_ps1 "${COLORED_LEFT_PROMPT}$(right_align)${COLORED_RIGHT_PROMPT}${NEWLINE}" " %# " "${fg_no_bold[blue]}%s${reset_color}"
}

# History settings
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

unsetopt FLOW_CONTROL	# Disable <C-s> <C-q>
bindkey -v				# Use vim keys for line editing

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

setopt complete_in_word

# Completion configuration
# :completion:function:completer:command:argument:tag.

#zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''

# Load ls colors
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''

#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select # Enable arrows
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false # Disable old completion system
zstyle ':completion:*' verbose true

# Cool kill completion
# However, there is one even more special effect you can use with the general pattern form. By turning on `backreferences' with `(#b)' inside the pattern, parentheses are active and the bits they match can be coloured separately. You do this by extending the list of colours, each code preceded by an `=' sign, and the extra elements will be used to colour what the parenthesis matched. Here's another example for `kill', which turns the process number red, but leaves the rest alone. 
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias gst='git status'
alias glg='git log --oneline'
alias glgg='git log --oneline --decorate --graph'
alias glgga='git log --oneline --decorate --graph --all'
alias gck='git checkout'

alias tmux='tmux -2'

alias ez='vim ~/.zshrc'
alias sz='source ~/.zshrc'
