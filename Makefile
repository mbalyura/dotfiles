CURRENT_DATE := $(shell date +"%Y.%m.%d_%H.%M.%S")

cp:
	cp ~/.gitconfig ./dotfiles
	cp ~/.gitignore ./dotfiles
	cp ~/tilix.json ./dotfiles
	cp ~/.bashrc ./dotfiles
	cp ~/.tmux.conf ./dotfiles
	cp ~/.config/Code/User/snippets/my.code-snippets ./config/Code/User/snippets/
	cp ~/.config/Code/User/keybindings.json ./config/Code/User/
	cp ~/.config/Code/User/settings.json ./config/Code/User/
# 	cp ~/.config/kanata/config ./kbd/kanata/config
	cp ~/Downloads/vimium-options.json ./kbd

apply-tmux:
	cp ./dotfiles/.tmux.conf ~ -v

apply-git:
	cp ./dotfiles/.gitconfig ~ -v
	cp ./dotfiles/.gitignore ~ -v

apply-bash:
	rm -rf ~/.bash/ -v
	cp -r ./dotfiles/.bash ~ -v
	cp ./dotfiles/.bashrc ~ -v
	@echo "Bash config applied. Run: source ~/.bashrc"

apply-vsc:
	cp -r ./config/Code ~/.config -v

apply-layout:
	sudo cp ./kbd/layout/ru_custom /usr/share/X11/xkb/symbols/ru_custom \
		&& sudo cp ./kbd/layout/en_custom /usr/share/X11/xkb/symbols/en_custom \
		# && sudo dpkg-reconfigure xkb-data

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
