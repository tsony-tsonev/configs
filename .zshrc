# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="random"
ZSH_THEME="philips"

# export TERM='rxvt-unicode-256color'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colorize cp history mosh mongodb kubectl zsh-autosuggestions zsh-syntax-highlighting zsh-navigation-tools)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

##########
# CUSTOM #
##########

# import private aliasess and configs
source $HOME/.zsh_private

#custom funct
function customFuncExample {
   command=$(pwd)

   #write the output of the command to the buffer
   BUFFER="$command"
   CURSOR=$#BUFFER
}
#load the func
zle -N customFuncExample_widget customFuncExample
#bind the func to key
bindkey '\ew' customFuncExample_widget
#double escape press for cancel autocomplete
bindkey '\e\e' send-break

### zsh-autosuggestions ###
#autosuggest-accept: Accepts the current suggestion.
#autosuggest-execute: Accepts and executes the current suggestion.
#autosuggest-clear: Clears the current suggestion.
#autosuggest-fetch: Fetches a suggestion (works even when suggestions are disabled).
#autosuggest-disable: Disables suggestions.
#autosuggest-enable: Re-enables suggestions.
#autosuggest-toggle: Toggles between enabled/disabled suggestions.
bindkey '^ ' autosuggest-accept
### ZAW ###
source $HOME/.oh-my-zsh/plugins/zaw/zaw.zsh
bindkey '^R' zaw-history
zstyle ':filter-select' max-lines 10
zstyle ':filter-select' hist-find-no-dups yes # ignore duplicates in history source
zstyle ':filter-select' escape-descriptions no # display literal newlines, not \n, etc

# VIM PATHOGEN export import update plugins
alias vplug-update=" ls -d -1 ~/.vim/bundle/* | xargs -I{} git -C {} pull"
alias vplug-export="ls -d -1 ~/.vim/bundle/* | xargs -I{} git -C {} remote -v | sed 's/^origin//' | sed 's/(fetch)*$//' | sed 's/(push)*$//' | uniq | sed 's/^[ \t ]*//;s/[ \t ]*$//' > vim-plugins"
function gitBulkClone {
    curDir=`pwd`
    cd ~/.vim/bundle
    while read repo; do
        git clone "$repo"
    done < ~/vim-plugins
    cd $curDir
}
alias vplug-import=gitBulkClone
# depends on python-pygments
# alias cat="colorize"
alias cat="colorize_via_pygmentize"


#Go
export GOPATH=$HOME/workspace/go/
export GOROOT=$HOME/development/go
export PROTOC=$HOME/development/protoc/bin
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin:$PROTOC

export GO111MODULE=on
