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


- **Bluetooth linux ploblems**

### Cant set audio profile:

  1. Enable MultiProfile support /etc/bluetooth/main.conf

On/near line 58, you'll see #MultiProfile = off. Uncomment (or add a new line) with MultiProfile = multiple.

  2. Remove the bluetooth device and re-add it.

This is important. Switching to A2DP did not work for me until I dropped and re-added.


### restart bluetooth service:

>     sudo service bluetooth restart