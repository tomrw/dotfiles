mv ~/Library/Application\ Support/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings__old.json
ln -s ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

mv ~/Library/Application\ Support/Code/User/keybindings.json ~/Library/Application\ Support/Code/User/keybindings__old.json
ln -s ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

mv ~/Library/Application\ Support/Code/User/snippets ~/Library/Application\ Support/Code/User/snippets-OLD
ln -s ~/dotfiles/vscode/snippets ~/Library/Application\ Support/Code/User/snippets

declare -a vsCodeExtensions=(
	"alefragnani.project-manager"
	"christian-kohler.npm-intellisense"
	"christian-kohler.path-intellisense"
	"dbaeumer.vscode-eslint"
	"DotJoshJohnson.xml"
	"EditorConfig.EditorConfig"
	"esbenp.prettier-vscode"
	"GitHub.vscode-pull-request-github"
	"mikestead.dotenv"
	"ms-vsliveshare.vsliveshare"
	"Prisma.vscode-graphql"
	"redhat.vscode-yaml"
	"samuelcolvin.jinjahtml"
	"TabNine.tabnine-vscode"
	"vscodevim.vim"
	"vscoss.vscode-ansible"
	"waderyan.gitblame"
	"wix.vscode-import-cost"
	"xabikos.JavaScriptSnippets"
	"yzhang.markdown-all-in-one"
	"kisstkondoros.vscode-codemetrics"
)

for extension in "${vsCodeExtensions[@]}"
do
	echo "Installing extension: $extension for VSCode"
	code --install-extension $extension
done
