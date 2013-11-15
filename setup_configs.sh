#!/bin/bash
cd ~
ln -sf ~/configs/zsh/.zshrc .zshrc
ln -sf ~/configs/ack/.ackrc .ackrc
cd  ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
ln -sf ~/configs/sublime/Preferences.sublime-settings Preferences.sublime-settings
mkdir  ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/TomorrowNight
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/TomorrowNight/
ln -sf ~/configs/sublime/Tomorrow-Night.tmTheme Tomorrow-Night.tmTheme
echo "" > ~/configs/zsh/machine_zsh_configs/empty.zsh
cd ~
