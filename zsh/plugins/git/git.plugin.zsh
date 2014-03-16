# Aliases
alias g='git'
compdef g=git
alias gcl='git clone'
alias gs='git status'
compdef _git gs=git-status
alias gst='git stash'
compdef _git gst=git-stash
alias gstp='git stash pop'
compdef _git gstp=git-stash
alias gd='git diff'
compdef _git gd=git-diff
alias gpull='git pull'
compdef _git gpull=git-pull
alias gp='git push'
compdef _git gp=git-push
alias gd='git diff'
gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff
alias gci='git commit -m'
compdef _git gci=git-commit
alias gcia='git commit --amend'
compdef _git gc!=git-commit
alias gc='git checkout'
compdef _git gc=git-checkout
alias gcm='git checkout master'
alias gr='git remote'
compdef _git gr=git-remote
alias grv='git remote -v'
compdef _git grv=git-remote
alias grmv='git remote rename'
compdef _git grmv=git-remote
alias grrm='git remote remove'
compdef _git grrm=git-remote
alias grset='git remote set-url'
compdef _git grset=git-remote
alias grup='git remote update'
compdef _git grset=git-remote
alias grb='git rebase'
compdef _git grb=git-rebase
alias grbi='git rebase -i'
compdef _git grbi=git-rebase
alias grbc='git rebase --continue'
compdef _git grbc=git-rebase
alias grba='git rebase --abort'
compdef _git grba=git-rebase
alias gb='git branch'
compdef _git gb=git-branch
alias gba='git branch -a'
compdef _git gba=git-branch
alias gcount='git shortlog -sn'
compdef gcount=git
alias gcp='git cherry-pick'
compdef _git gcp=git-cherry-pick
alias gl='git log --oneline --decorate --all --graph'
compdef _git gl=git-log
alias gfr='git-forest -a --sha | less -RS'
alias ga='git add'
compdef _git ga=git-add
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gclean='git reset --hard && git clean -dfx'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
alias gls='git ls-files | grep'
alias gpoat='git push origin --all && git push origin --tags'
alias gmt='git mergetool --no-prompt'
compdef _git gm=git-mergetool
alias gf='git fetch'
compdef _git gf=git-fetch

# Will cd into the top of the current repository
# or submodule.
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'

# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
compdef ggpull=git
alias ggpur='git pull --rebase origin $(current_branch)'
compdef ggpur=git
alias ggpush='git push origin $(current_branch)'
compdef ggpush=git
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
compdef ggpnp=git
