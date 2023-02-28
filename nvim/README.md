# nvim
my nvim config

## clean the original config
mv ~/.local/share/nvim ~/.local/share/nvim.bak  
mv ~/.local/state/nvim ~/.local/state/nvim.bak  
mv ~/.cache/nvim ~/.cache/nvim.bak  

## dependecies
+ python3
+ pip3
+ python3-venv
+ nodejs
+ npm
+ ripgrep
+ unzip
+ git (PPA)
+ xclip

## python3-venv
```
sudo apt install python3-venv
```

## Node.js v16.x
[ref](https://github.com/nodesource/distributions/blob/master/README.md)  
```
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
```

## ripgrep
[ref](https://github.com/BurntSushi/ripgrep)  
For Ubuntu 18.04 (or older) :  
```
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
```
Else :  
```
sudo apt install ripgrep
```

## unzip
```
sudo apt install unzip
```

## git(PPA)
[ref](https://launchpad.net/~git-core/+archive/ubuntu/ppa)
```
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git
```

## LaTeX+Okular+Neovim
[ref](https://www.bbsmax.com/A/Vx5MojXpzN/)  
texlive:  
```
sudo apt install texlive-full
```  
neovim-remote:  
```
pip3 install neovim-remote
```  
okular:  
```  
sudo apt install okular
```  
To configure the inverse-search, in Okular, 'Settings->Configure Okular->Editor->Custom Text Editor':  
```
nvim --headless -c "VimtexInverseSearch %l '%f'"
```  

## xclip
It's important for neovim to connect with the system clipboard  
```
sudo apt install xclip
```  
