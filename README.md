## My personal config files
### ***just backup***


___
- **Vscode multi-line edit/select on linux mint**

> Go to Preferences > Windows. In the Behavior tab, under Moving and Resizing Windows I have disabled Special key to move and resize windows. It was Alt by default. In VSCode I set Alt as Keybinding for Toggle Multi-Cursor Modifier and it now works.

https://stackoverflow.com/questions/60272595/vscode-multi-line-edit-select-on-linux-mint


- **Переключение языка по Ctrl+Shift и проблемы в Ubuntu**
>
>     sudo apt-get install gnome-tweak-tool
>
> Далее ищем его в поиске программ введя «Дополнительные настройки Gnome»,
> там выбираем «Клавиатура и мышь»,
> далее жмем кнопку «дополнительные параметры раскладки»,
> и в секции «Переключение на другую раскладку» — выбираем то что нам нравится. Мне нравится Ctrl+Shift.
>
>       sudo add-apt-repository ppa:nrbrtx/xorg-hotkeys
>       sudo apt-get update
>       sudo apt-get dist-upgrade

https://maxidrom.net/archives/1564

- **Make Fn + F-keys work on Keychron Keyboards**
> ### Add the option for the fn key
>       echo options applespi fnmode=2 | sudo tee -a /etc/modprobe.d/applespi.conf
> ### Update initramfs bootfile
>       sudo update-initramfs -u
> ### Reboot to test (optional)
>       sudo reboot

https://jkfran.com/keychron-keyboard-linux-secrets/