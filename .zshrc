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
# SOLARIZED_THEME="dark"

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
zstyle ':omz:update' frequency 14

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
COMPLETION_WAITING_DOTS="true"

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
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

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
alias cleandisk="baobab"
alias cl="clear"
alias vi="nvim"
alias svi="sudoedit"
alias deb="sudo dpkg -i"
alias debrem="sudo dpkg -r"
alias update-chrome="sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb"

alias tm="tmux"
alias tml="tmux ls"
alias tma="tmux a -t "
alias tmk="tmux kill-session -t "
alias tx="tmuxifier"
alias txl="tmuxifier load-session"
alias txd="tmuxifier load-session dchess"
alias txp="tmuxifier load-session portfolio"
alias txc="tmuxifier load-session catlas"
alias txi="tmuxifier load-session ichi-guy"
# alias pa="php artisan"
# alias sail="[ -f sail ] && sh sail || sh vendor/bin/sail"
# alias sf="fdfind --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"

# alias glr="git pull $(pwd | awk -F/ '{print $NF}') $(git_current_branch)"
alias gt="git worktree"
alias gk="git checkout"
alias gkm="git checkout main"
alias gh="git stash"
alias gs="git status"
alias gfa='f() { git ${2:---git-dir=.git} fetch --prune ${1:-gitlab} "*:*"};f'
alias gw="git show"
alias grpo="git remote prune origin"
alias gsl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- <%an>%C(auto)%d%Creset' --all"

# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias .c="~/.config"
alias .ca="~/.config/awesome; vi rc.lua"
alias .cn="~/.config/nvim; vi"
alias .cz="vi ~/.zshrc"
alias D="~/Downloads"

alias d="docker"
alias dp="docker ps"
alias dps="docker ps --format 'table {{.Image}}\t{{ .Ports }}'"
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"

# alias i="~/ichi-guy/"
# alias iv="~/ichi-guy/; vi"
alias co="~/code/"
alias cot="~/code/ts"
alias cop="~/code/php"
alias coy="~/code/py"
alias coa="~/code/astro"
alias p="~/code/astro/portfolio"

# Random Devs
alias r="~/rd/"
alias rb="~/rd/bank-lead/"

# DChess
alias c="~/dchess/client"
alias w="~/dchess/server/game-chess"
alias a="~/dchess/server/auth-system"
alias aws="~/dchess/aws"
alias oc="~/dchess/.old/game-client-new"
alias oc2="~/dchess/.old/game-client"
alias ol2="~/dchess/.old/LandingGameStatic-legacy"
alias ol="~/dchess/.old/landing-page"
alias ob="~/dchess/.old/backend-setup"
alias obu="~/dchess/.old/backend-setup; git pull; ./up.sh"
alias ow="~/dchess/.old/backend-setup/game-ws"
alias os="~/dchess/.old/backend-setup/game-server"
alias om="~/dchess/.old/backend-setup/match-service"
alias ot="~/dchess/.old/backend-setup/tournaments"

alias auris="bluetoothctl connect 1C:52:16:E4:50:0F"
alias aurisd="bluetoothctl disconnect 1C:52:16:E4:50:0F"
alias headphones="bluetoothctl connect F5:F4:1F:3A:4C:0E"
alias headphonesd="bluetoothctl disconnect F5:F4:1F:3A:4C:0E"
alias speakers="bluetoothctl connect C0:9C:5F:99:6E:48"
alias speakersd="bluetoothctl disconnect C0:9C:5F:99:6E:48"

alias wifi='f() { nmcli device wifi connect $1 password $2};f'
alias wifid='f() { nmcli c down $1};f'
alias wifil='nmcli device wifi list'

alias md='f() { mkdir $1; cd $1};f'

# Generated for envman. Do not edit.
# [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/repos/powerlevel10k/powerlevel10k.zsh-theme

# If you come from bash you might have to change your $PATH.
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/usr/bin
export PATH=$PATH:$HOME/usr/local/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.config/composer/vendor/bin
export PATH=$PATH:$HOME/repos/tmuxifier/bin
export PATH=$PATH:$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
export PATH=$PATH:$HOME/scripts
export PATH=$PATH:$HOME/appImages/
export PATH=$PATH:/usr/pgadmin4/bin

export EDITOR='nvim'
export XDG_CONFIG_HOME="$HOME/.config"
export GIT_SSH_COMMAND='ssh -i ~/.ssh/pc-ubuntu'
export PRETTIERD_LOCAL_PRETTIER_ONLY=true
export FZF_DEFAULT_OPTS="--reverse --preview 'cat {}' --prompt='  ' --pointer=' ▶'" # --pointer=' →'

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVESIZE=10000

eval "$(tmuxifier init -)"

# eval "$(ssh-agent -s)"
# for key in ~/.ssh/*; do
#     [ -f "$key" ] && [[ "$key" != *.pub ]] && ssh-add "$key" < /dev/null
# done

bindkey '^k' autosuggest-accept

# pnpm
export PNPM_HOME="/home/greg/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
