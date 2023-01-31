# Download Guide
This is a note/list/cheatsheet for downloading some useful software, which can't be obtained easily by  
```
sudo apt install xxx
```
**Mainly for Ubuntu 18.04**  

[TOC]

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

## git(PPA)
[ref](https://launchpad.net/~git-core/+archive/ubuntu/ppa)
```
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git
```

## cuda (eg. 11.3 for ubuntu 18.04)
[ref](https://developer.nvidia.com/cuda-11.3.0-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=18.04&target_type=runfile_local)
```
wget https://developer.download.nvidia.com/compute/cuda/11.3.0/local_installers/cuda_11.3.0_465.19.01_linux.run
sudo ./cuda_11.3.0_465.19.01_linux.run
```

## cudnn
[ref](https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html#verify)  
[download](https://developer.nvidia.com/rdp/cudnn-download)
```
tar -xvf cudnn-linux-x86_64-8.x.x.x_cudaX.Y-archive.tar.xz
sudo cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda/include 
sudo cp -P cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64 
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
```

## libtorch
[Stable version](https://pytorch.org/get-started/locally/)  
[Previous version](https://github.com/pytorch/pytorch/issues/40961)  
eg. libtorch 1.11.0 cuda-11.3  
```
wget https://download.pytorch.org/libtorch/cu113/libtorch-shared-with-deps-1.11.0%2Bcu113.zip
```

## CloudCompare
[ref](https://github.com/cloudcompare/cloudcompare)  
```
sudo snap install cloudcompare
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
