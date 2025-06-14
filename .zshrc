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

# ls → eza（カラー&tree風表示）
alias ls='eza'

# cat → bat（シンタックスハイライト付きcat）
alias cat='bat'

# ll → eza -la（詳細かつ隠しファイル含むリスト）
alias ll='eza -la'


# ========================
# 🔁 gitのブランチなどをプロンプトに表示
# ========================

# vcs_info を使って、Gitリポジトリ情報を取得
autoload -Uz vcs_info

# プロンプトを表示するたびに vcs_info を実行
precmd() { vcs_info }

# --- 必須 ---
setopt prompt_subst

get_git_branch() {
  git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

  echo " $branch"
}

# --- 一つ前のディレクトリと現在のディレクトリを表示 ---
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
PROMPT='%F{magenta}%B$(get_short_path)%b%f  %F{yellow}$(get_git_branch)%f
❯ '
