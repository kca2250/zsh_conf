# ========================
# zsh設定ファイル（~/.config/zsh/.zshrc）
# ========================

# 💡 ZDOTDIRの指定により、zshの設定ファイルを ~/.config/zsh にまとめる
export ZDOTDIR="$HOME/.config/zsh"

source $ZDOTDIR/.antidote/antidote.zsh
source $ZDOTDIR/plugins.zsh


# ========================
# 🛠 パス・エディタ・表示設定など
# ========================

# ✍ デフォルトエディタをnvimに設定
export EDITOR=nvim

# ========================
# 📁 よく使うコマンドのエイリアス設定
# ========================

alias ls='eza'
alias cat='bat'
alias ll='eza -la'

# ========================
# 🔁 gitのブランチなどをプロンプトに表示
# ========================

autoload -Uz vcs_info
precmd() { vcs_info }

setopt prompt_subst

get_git_branch() {
  git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

  echo " $branch"
}

get_short_path() {
  local full_path="${PWD/#$HOME/~}"  # ホームディレクトリを ~ に
  local IFS="/"                      # 区切り文字を / に
  local parts=(${(s:/:)full_path})   # パスを配列に分解
  local count=${#parts[@]}

  if [[ $count -ge 2 ]]; then
    echo "${parts[-2]}/${parts[-1]}"
  else
    echo "${parts[-1]}"
  fi
}

# --- プロンプト設定 ---
PROMPT='%F{cyan}%B$(get_short_path)%b%f  %F{yellow}$(get_git_branch)%f
$ '

# pnpm
export PNPM_HOME="/Users/kenichirokato/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
