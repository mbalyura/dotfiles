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
# 	cp ~/.config/kanata/config ./kbd/kanata/config
	cp ~/Downloads/vimium-options.json ./kbd

apply-tmux:
	cp ./dotfiles/.tmux.conf ~ -v

apply-git:
	cp ./dotfiles/.gitconfig ~ -v
	cp ./dotfiles/.gitignore ~ -v

apply-bash:
	cp ./dotfiles/.bashrc ~ -v

apply-vsc:
	cp ./vscode/my.code-snippets ~/.config/Code/User/snippets/ -v
	cp ./vscode/keybindings.json ~/.config/Code/User/ -v
	cp ./vscode/settings.json ~/.config/Code/User/ -v

apply-layout:
	sudo cp ./kbd/layout/ru_custom /usr/share/X11/xkb/symbols/ru_custom \
		&& sudo cp ./kbd/layout/en_custom /usr/share/X11/xkb/symbols/en_custom \
		&& sudo dpkg-reconfigure xkb-data

apply-all:
	make apply-tmux
	make apply-git
	make apply-bash
	make apply-vsc
	cp ./dotfiles/tilix.json ~ -v
# 	cp ~/.config/kanata/config ./kbd/kanata/config
# 	cp ~/Downloads/vimium-options.json ./kbd

push:
	git add . -f && git commit -m 'backup_${CURRENT_DATE}' && git push

backup:
	make cp
	make push
