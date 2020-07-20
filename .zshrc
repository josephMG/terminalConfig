# Path to your oh-my-zsh installation.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f ~/.profile ]; then
    . ~/.profile
fi
export ZSH=$HOME/.oh-my-zsh
printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="arrow"
#ZSH_THEME="pygmalion"
#ZSH_THEME="ys"

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_TIME_FORMAT="%D{\u23f0 %H:%M}"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
plugins=(rails ruby autojump git zsh-syntax-highlighting zsh-autosuggestions)
#plugins=(rails ruby autojump git zsh-syntax-highlighting)

bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
source $ZSH/oh-my-zsh.sh

# User configuration
#NDK=/home/joseph/Downloads/android-ndk-r10d
#export NDK
#export PATH=$PATH:$NDK:"/home/joseph/.rvm/gems/ruby-2.1.2/bin:/home/joseph/.rvm/gems/ruby-2.1.2@global/bin:/home/joseph/.rvm/rubies/ruby-2.1.2/bin:/home/joseph/.rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
#export PATH=$PATH:$NDK

PATH=$PATH:/snap/bin
export PATH

#export NDK_MODULE_PATH="/home/joseph/Downloads/OpenNI/Platform/Android/jni/"
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
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add ~/.ssh/lentex_digitalocean
  ssh-add ~/.ssh/clik_u_gitlab
  ssh-add ~/.ssh/gitlab
fi
function git_diff() {
	git diff --no-ext-diff -w "$@" | vim -R -
}

function t() {
  # Configure a PuTTY profile to send "t" as the "Remote command". This function will automatically reattach to an existing tmux session if one exists, or start a new one. This function also repeatedly sends our homemade tmux clipboard back to the PuTTY client in the form of an ANSI printer escape sequence. The contents of the homemade clipboard are populated by `bind -t vi-copy y copy-pipe 'cat > ~/.tmux-buffer'` in tmux.conf. It is expected that the PuTTY client will be configured to print to a "Microsoft XPS Document Writer" which saves the printer output to a file. The file is subsequently read by an AutoHotkey macro, and the contents are made available for paste.
  [[ "$TERM" == "xterm" ]] || return 0 # This prevents recursive runs, in case t() is called after tmux is started.
#  { while :; do tput mc5; cat ~/.tmux-buffer; tput mc4; sleep 5; done } &
  tmux -2 attach || tmux -2
}

#export TERM="xterm"
#export TERM="xterm-256color"
export FACEBOOK_KEY=""
export FACEBOOK_SECRET=""
export GOOGLE_CLIENT_ID=""
export GOOGLE_CLIENT_SECRET=""
export GOROOT=/usr/local/go
#export GOPATH=/var/www/html/golang/test_go
#export GOBIN=$GOPATH/bin
export PATH="$PATH:${GOROOT}/bin"
setopt NO_NOMATCH

[[ -s /home/joseph/.autojump/etc/profile.d/autojump.sh ]] && source /home/joseph/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
function ad {
  zle autosuggest-disable
}
function ae {
  zle autosuggest-enable
}
zstyle :bracketed-paste-magic paste-init ad
zstyle :bracketed-paste-magic paste-finish ae
