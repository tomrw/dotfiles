nt() {
	if [ -f package.json ]; then
		npm run test
	elif [ -f Pipfile ]; then
		pipenv run test
	else
		echo "no test script found"
	fi
}

use() {
	local branch=${1:-master}
	local previousDir=$(pwd)

	git fetch origin
	git checkout $branch

	if [ $branch = 'master' ] && [ $(which hub) ]; then
		hub sync
	fi

	if [[ ! `git status --porcelain` ]]; then
		git pull
		git reset --hard origin/$branch
	fi

	if [ $(basename $(dirname $(pwd))) = 'packages' ] && [ -f ../../lerna.json ]; then
		cd ../../
	fi

	if [ -f .nvmrc ]; then
		nvm install $(cat .nvmrc)
	fi

	if [ -f package.json ]; then
		yarn
	fi

	if [ -f lerna.json ] && [ $(which lerna) ]; then
		lerna bootstrap
	fi

	cd $previousDir
}
