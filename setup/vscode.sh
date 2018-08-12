mv ~/Library/Application\ Support/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings__old.json
ln -s ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

declare -a vsCodeExtensions=(
	"EditorConfig.EditorConfig"
	"alefragnani.project-manager"
	"christian-kohler.npm-intellisense"
	"christian-kohler.path-intellisense"
	"dbaeumer.vscode-eslint"
	"lukehoban.Go"
	"ms-vscode.atom-keybindings"
	"vscodevim.vim",
	"wix.vscode-import-cost"
)

for extension in "${vsCodeExtensions[@]}"
do
	echo "Installing extension: $extension for VSCode"
	code --install-extension $extension
done
