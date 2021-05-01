# Neovim

## synchronize with linux machine
---
### prerequiste
```
sudo apt install curl git
```
### using curl
```
curl https://raw.githubusercontent.com/ChiftKey/myconfig/main/neovim/init.vim -o ${XDG_CONFIG_HOME:-~/.config}/nvim/init.vim
```