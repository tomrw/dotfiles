#!/bin/bash

red='\033[0;31m'
NC='\033[0m' # No Color

for d in */ ; do
	cd "./$d"
	if [ -d ".git" ]; then
		echo -e "${red}* $d Status:${NC}"
		git status
		echo '------------------------------'
	fi
	cd "../"
done
