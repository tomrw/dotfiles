#!/bin/bash

red='\033[0;31m'
NC='\033[0m' # No Color

for d in */ ; do
	cd "./$d"
	if [ -d ".git" ]; then
		echo -e "${red}Running a pull on $d${NC}"
		git pull
	fi
	cd "../"
done
