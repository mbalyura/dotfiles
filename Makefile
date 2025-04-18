CURRENT_DATE := $(shell date +"%Y.%m.%d_%H.%M.%S")

cp:
	cp ~/.gitconfig ./dotfiles
	cp ~/.gitignore ./dotfiles
	cp ~/tilix.json ./dotfiles
	cp ~/.bashrc ./dotfiles
	cp ~/.tmux.conf ./dotfiles
	cp ~/.config/Code/User/snippets/my.code-snippets ./vscode
	cp ~/.config/Code/User/keybindings.json ./vscode
	cp ~/.config/Code/User/settings.json ./vscode
	cp ~/.config/kanata/config ./kbd/kanata/config
	cp ~/Downloads/vimium-options.json ./kbd

backup:
	make cp
	git add . -f && git commit -m 'backup_${CURRENT_DATE}' && git push