mv ~/Library/Application\ Support/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings__old.json
ln -s ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

mv ~/Library/Application\ Support/Code/User/keybindings.json ~/Library/Application\ Support/Code/User/keybindings__old.json
ln -s ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

declare -a vsCodeExtensions=(
	"alefragnani.project-manager"
	"christian-kohler.npm-intellisense"
	"christian-kohler.path-intellisense"
	"dbaeumer.vscode-eslint"
	"EditorConfig.EditorConfig"
	"GitHub.vscode-pull-request-github"
	"mikestead.dotenv"
	"ms-vsliveshare.vsliveshare"
	"redhat.vscode-yaml"
	"samuelcolvin.jinjahtml"
	"vscodevim.vim"
	"vscoss.vscode-ansible"
	"waderyan.gitblame"
	"wix.vscode-import-cost"
	"xabikos.JavaScriptSnippets"
	"yzhang.markdown-all-in-one"
	"esbenp.prettier-vscode"
)

for extension in "${vsCodeExtensions[@]}"
do
	echo "Installing extension: $extension for VSCode"
	code --install-extension $extension
done
