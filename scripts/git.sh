#!/bin/bash

if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi

alias s="git status"
alias co="git checkout"
alias p="git pull"
alias d="git diff"
alias dw="git diff --color-words --word-diff-regex='\\w+|[^[:space:]]'"
alias dc="d --cached"
alias dwc="dw --cached"
alias a="git add ."
alias ad="git add"
alias c="git commit -m"
alias b="git branch"
alias gfo="git fetch origin"
alias lg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias sp="git show -p"
alias gm="git merge"
alias ri="git rebase -i"
alias com="git checkout master"
alias clearAllBranches="git branch --merged | grep -v \* | xargs git branch -D"
alias who="git shortlog -s --"
alias bp="~/dotfiles/scripts/git-pull.sh"
alias bs="~/dotfiles/scripts/git-status.sh"
alias amend="git commit --amend"

getBranch() {
	local branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)

	echo "$branch"
}

# lc - Lazy Commit
lc() {
	if [ "$1" = "" ]; then
		echo "Please supply a commit message"
		return 0
	fi

	local msg=""

	for arg in "$@"
	do
		msg+="$arg "
	done

	git commit -m "$msg"
}

cs() {
	if [ "$1" = "" ]; then
		echo "Please supply a commit message"
		return 0
	fi

	local branch=$(getBranch)
	local msg=""

	for arg in "$@"
	do
		msg+=" $arg"
	done

	if [ "$branch" != "master" ]; then
		git commit -m "$branch:$msg"
	else
		echo "Not commiting as story - On master"
	fi
}

pnb() {
	local branch=$(getBranch)

	git push -u origin $branch
}

rsh() {
	local branch=$(getBranch)

	git reset --hard origin/$branch
}

testAll() {
	if [ "$1" = "" ]; then
		echo "Please supply a commit hash"
		return 0
	fi

	git rebase --exec "npm t" $1
}

testBranchCommits() {
	local head=$(git rev-parse origin/HEAD)

	git rebase --exec "npm t" $head
}

commitDiff() {
	local branch=${1:-$(getBranch)}
	local behind=$(git rev-list --left-only --count master...$branch)
	local ahead=$(git rev-list --right-only --count master...$branch)
	local green='\033[0;32m'
	local NC='\033[0m'

	echo -e "$branch is ${green}$behind${NC} commits behind master and ${green}$ahead${NC} commits ahead of master"
}

removeAllTags() {
	git tag -l | xargs git tag -d
	git fetch
	git tag -l | xargs -n 1 git push --delete origin
	git tag -l | xargs git tag -d
}
