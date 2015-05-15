[[ -s ~/tools/z/z.sh ]] && source ~/tools/z/z.sh

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

clonePlugin() {
	git clone git@github.gamesys.co.uk:client-delivery-platform/console-plugin-$1.git ~/workspace/$1
	cd ~/workspace/$1
}

clone() {
	git clone git@github.gamesys.co.uk:client-delivery-platform/$1.git ~/workspace/$1
	cd ~/workspace/$1
}

md() {
	mkdir -p "$@" && cd "$@";
}

untar() {
	tar -zxvf $1
}

myip() {
	ifconfig | grep "inet 10."
}

killPort() {
	if [ -z "$1" ]; then
		echo "Usage: searchAndDestroy [numeric port identifier]" >&2
		return 1
	fi
	lsof -i TCP:$1 | awk '/LISTEN/{print $2}' | xargs kill -9
}

alias s="git status"
alias co="git checkout"
alias p="git pull"
alias d="git diff"
alias dc="git diff --cached"
alias a="git add ."
alias ad="git add"
alias c="git commit -m"
alias b="git branch"
alias gfo="git fetch origin"
alias lg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

alias gbd="grunt build-dev"
alias ..="cd .."
alias who="git shortlog -s --"
alias gt="grunt test"
alias nt="npm test"
alias wt="npm run watch-tests"

alias bp="~/git-pull.sh"
alias check2="check --env chat.dev"
