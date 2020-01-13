md() {
	mkdir -p "$@" && cd "$@";
}

untar() {
	tar -zxvf $1
}

alias ..="cd .."
alias 2..=".. && .."
alias 3..=".. && .. && .."
alias cat=bat

mkdir -p ~/workspace
