if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search you-should-use auto-notify web-search docker extract)

source $ZSH/oh-my-zsh.sh

alias hibernate="sudo systemctl hibernate"
alias pa="php artisan"
alias codeng="code -d --profile angular_profile"
alias codej="code -d --profile java_profile"
alias code="code -d"
alias ls="eza --icons=always"
alias cursor="/opt/cursor.appimage"

eval "$(zoxide init zsh)"
alias cd="z"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="/opt/apache-maven-3.9.9/bin:$PATH"
# export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"

# Load Angular CLI autocompletion.
source <(ng completion script)

# TheFuck
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# -------------------------------FZF--------------------------
# FZF setup
if [[ ! "$PATH" == */usr/share/fzf/bin* ]]; then
  export PATH="$PATH:/usr/share/fzf/bin"
fi

# FZF key bindings and fuzzy completion
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Sử dụng fd thay cho find trong FZF (nếu đã cài fd)
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Thiết lập màu sắc cho FZF
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# Phím tắt FZF cho lệnh cd
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# -------- Bat ------
export BAT_THEME=tokyonight_night

# Reload Zsh configuration
alias reload-zsh="source ~/.zshrc"
