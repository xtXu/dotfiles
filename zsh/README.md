# This is my ZSH config
Using zi as the plugin manager.

## Dependencies
+ fzf
+ fd
+ ripgrep

## Usage
```bash
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
```

## Notice
Source the ros-melodic by default.  
Set the proxy as 127.0.0.1:7890 (clash) by default.

## Zi
Some cli-tool settings wasting a lot of time when startup (eg. fzf, conda) are move to a zsh snippet in the corresponding directory.  
Then the snippets (settings) can be lazy loaded by zi.

