mkdir -p ~/.hammerspoon

if [ ! -f ~/.hammerspoon/init.lua ]; then
	ln -s ~/dotfiles/hammerspoon/init.lua ~/.hammerspoon/init.lua
fi
