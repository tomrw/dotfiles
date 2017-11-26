if [ ! -d plugins ]; then
	echo "Making plugins dir"
	mkdir plugins
else
	echo "Not making plugins dir - already exists"
fi

cd plugins

if [ ! -d git-aware-prompt ]; then
	git clone git@github.com:jimeh/git-aware-prompt.git
else
	echo "Not cloning git-aware-promt plugin - already exists"
fi
