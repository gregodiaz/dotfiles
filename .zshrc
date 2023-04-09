# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$HOME/.composer/vendor/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"
# ZSH_THEME="powerlevel10k/powerlevel10k"
# 'p10k configure' to reset de configure
SOLARIZED_THEME="dark"

# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"

 # Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

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
#
# sudo -n chmod a+rw /sys/class/backlight/intel_backlight/brightness

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias cl="clear"
# alias vi="nvim"
alias vi="neovide --multigrid --maximized"
alias pa="php artisan"
alias wpp="whatsdesk"
alias sail="[ -f sail ] && sh sail || sh vendor/bin/sail"

alias gcmm="git commit -m"
alias gcmma="git commit -am"
alias gcam="git commit --amend"
alias gcko="git checkout"
alias gckom="git checkout main"
alias gpsh="git push"
alias gpll="git pull"
# alias gpllr="git pull $(pwd | awk -F/ '{print $NF}') $(git_current_branch)"
alias gsth="git stash"
alias gshw="git show"
alias grp="git remote prune "
alias gsl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- <%an>%C(auto)%d%Creset' --all"
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias .c="~/.config"
alias .ca="neovide --multigrid --maximized ~/.config/awesome"

alias d="docker"
alias dp="docker ps"
alias dps="docker ps --format 'table {{.Image}}\t{{ .Ports }}'"
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"

alias i="~/ichi-guy/"
alias iv="~/ichi-guy/; vi"

alias w="~/dchess/backend-setup/game-ws"
alias c="~/dchess/game-client"
alias s="~/dchess/backend-setup/game-server"
alias m="~/dchess/backend-setup/match-service"
alias t="~/dchess/backend-setup/tournaments"
alias b="~/dchess/backend-setup"
alias bu="~/dchess/backend-setup; git pull; ./up.sh"

alias auris="bluetoothctl connect 1C:52:16:E4:50:0F"
alias aurisd="bluetoothctl disconnect 1C:52:16:E4:50:0F"
alias headphones="bluetoothctl connect F5:F4:1F:3A:4C:0E"
alias headphonesd="bluetoothctl disconnect F5:F4:1F:3A:4C:0E"

alias wifi='f() { nmcli device wifi connect $1 password $2};f'
alias wifid='f() { nmcli c down $1};f'
alias wifilist='nmcli device wifi list'
 

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.config/composer/vendor/bin:$PATH:$$HOME/usr/bin:$PATH:$$HOME/.local/bin:$PATH

export VISUAL=/usr/local/bin/neovide
export EDITOR="$VISUAL"

export GH_API_KEY=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
export OPENAI_API_KEY=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
