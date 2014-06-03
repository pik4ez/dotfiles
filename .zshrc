# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh/

ZSH_CUSTOM=~/zsh/

SOLARIZED_THEME=light

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="tt4"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git history-substring-search)

source $ZSH/oh-my-zsh.sh

export PATH=/home/$(whoami)/bin:/home/$(whoami)/gocode/bin:$PATH

# history search settings
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=cyan,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

# key mappings
autoload zkbd
zkbd_file=~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
[ -f $zkbd_file ] && source $zkbd_file

[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" history-substring-search-up
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" history-substring-search-down
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line

bindkey "[C" forward-word
bindkey "[D" backward-word

# aliases
alias pl="mpc -f \"%position%\t [[%artist% — ][%title%]|[%file%]]\" playlist"
alias pla="mpc -f \"%position%\t [[%artist% — ][%album% — ][%title%]|[%file%]]\" playlist"

# add "sudo" in front of command
zle -N prepend-sudo prepend_sudo
bindkey "^S" prepend-sudo
function prepend_sudo() {
	BUFFER="sudo "$BUFFER
	CURSOR=$(($CURSOR+5))
}
