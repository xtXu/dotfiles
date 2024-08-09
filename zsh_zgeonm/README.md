# This is my ZSH config
Using zgenom as the plugin manager.

## Dependencies
+ fzf
+ fd
+ ripgrep

## Usage
```bash
ln -s ~/dotfiles/zsh_zgenom/.zshrc ~/.zshrc
```

## QA
### Repeated input when auto completion
```bash
sudo apt install locales

locale-gen en_US.UTF-8

# check if /etc/locale.gen exists
# check if 'en_US.UTF-8 UTF-8' the file
# if not, 
sudo echo en_US.UTF-8 UTF-8 > /etc/locale.gen

echo "export LC_ALL=en_US.UTF-8" >> /root/.bashrc
```
