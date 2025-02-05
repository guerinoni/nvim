source ~/.alias

export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# don't save commands starting with space
setopt HIST_IGNORE_SPACE

# share history across multiple zsh sessions
setopt SHARE_HISTORY

# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY

# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST

# Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS

# Don't write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS

# do not store duplications
setopt HIST_IGNORE_DUPS

#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS

# removes blank lines from history
setopt HIST_REDUCE_BLANKS

parse_git_branch() {
    git symbolic-ref --short HEAD 2> /dev/null
}

setopt PROMPT_SUBST
# set prompt with last operation
PROMPT='%F{yellow}%D{%H:%M:%S}%f %(?.%F{green}✅.%F{red}❌%?)%f %B%F{240}%1~%f%b $(parse_git_branch) %F{magenta}$(git_status)%f %# '

git_status() {
  git status --porcelain 2>/dev/null | grep -q . && echo "✚" || echo ""
  [[ $(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null | awk '{print $1}') -gt 0 ]] && echo "⇡"
  [[ $(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null | awk '{print $2}') -gt 0 ]] && echo "⇣"
}

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# trim space path like `Application Support/`
export PATH=$(echo $PATH | sed 's/\ /\\ /g')
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export PATH="/Users/guerra/.local/bin:$PATH"

export PATH="/Users/guerra/go/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GPG_TTY=$(tty)
# to avoid this just hit one time ssh-add --apple-use-keychain ~/.ssh/your_private_key
# eval $(ssh-agent)
# ssh-add --apple-use-keychain

eval "$(atuin init zsh)"
eval "$(direnv hook zsh)"
