# ----- Thiết lập PATH cơ bản (luôn ở đầu) -----
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# ----- Powerlevel10k Instant Prompt -----
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----- ZSH & Oh-My-Zsh setup -----
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# ----- nvm setup -----
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# ----- zoxide setup -----
eval "$(zoxide init zsh)"

# ----- gvm setup -----
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# ----- Thêm các đường dẫn bổ sung vào PATH (Cargo, LM Studio, Dart, OpenJDK, Android, pipx) -----
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/.lmstudio/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="/usr/local/opt/openjdk@21/bin:$PATH"

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"

#JAVA
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH="$JAVA_HOME/bin:$PATH"

export NEOVIDE_TABS=1

# ----- Aliases -----
alias zshconfig="source ~/.zshrc"
alias gpl="git pull"
alias gps="git push"
alias gcl="git clone"
alias node14="nvm use 14"
alias node18="nvm use 18"
alias node20="nvm use 20"
alias go23="gvm use go1.23.0 --default"          
alias go17="gvm use go1.17.0 --default"          
alias docps="docker ps -a"
alias doco="docker compose"
alias ldoc="lazydocker"
alias neovide="open -n -a Neovide"

alias yw="yarn workspace"
alias yws="yarn workspaces"

alias logs="cd /Users/bo-minh/Work && ./bo-logs-viewer"

# ----- Prompt Configuration -----
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
precmd () { print -Pn "\e]0;%~\a" }

# ----- Environment variables -----
export AVANTE_GEMINI_API_KEY=""
export GEMINI_API_KEY=""

alias python=/usr/bin/python3

# Dart completion script
[[ -f "$HOME/.dart-cli-completion/zsh-config.zsh" ]] && . "$HOME/.dart-cli-completion/zsh-config.zsh" || true
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

eval $(thefuck --alias)

# bun completions
[ -s "/Users/bo-minh/.bun/_bun" ] && source "/Users/bo-minh/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
