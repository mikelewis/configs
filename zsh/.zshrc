# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias postgres_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias postgres_reload="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log reload"
alias postgres_stop="pg_ctl -D /usr/local/var/postgres stop"

export EDITOR="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl --wait"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git gitfast mvn sublime)

source $ZSH/oh-my-zsh.sh

source $ZSH/plugins/history-substring-search/history-substring-search.zsh

typeset -g __CURRENT_GIT_BRANCH=
typeset -gi __CURRENT_GIT_BRANCH_DIRTY=1

parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

preexec_functions+='zsh_preexec_update_git_vars'
zsh_preexec_update_git_vars() {
	case "$(history $HISTCMD)" in
		*git*)
			typeset -gi __CURRENT_GIT_BRANCH_DIRTY=1 ;;
	esac
}

chpwd_functions+='zsh_chpwd_update_git_vars'
zsh_chpwd_update_git_vars() {
	typeset -gi __CURRENT_GIT_BRANCH_DIRTY=1
}

precmd_functions+='zsh_precmd_undirty_branch'
zsh_precmd_undirty_branch() {
	if [[ $__CURRENT_GIT_BRANCH_DIRTY -ne 0 ]]
	then
		typeset -gi __CURRENT_GIT_BRANCH_DIRTY=0
		typeset -g __CURRENT_GIT_BRANCH="$(parse_git_branch)"
	fi
}

get_git_prompt_info() {
	echo $__CURRENT_GIT_BRANCH
}

function b(){
	echo $(current_branch)
}

PROMPT=$'%n@%m:%{\e[0;37m%}%~%{\e[0;32m%}$(get_git_prompt_info)%{\e[0m%}$ '

for file in ~/configs/zsh/machine_zsh_configs/*.zsh
do
 [ -f "$file" ] && source "$file"
done
