# This is my i3 window manager config

## Usage
```bash
ln -s ~/dotfiles/i3 ~/.config/i3
```

## Dependencies
+ polybar
+ rofi
+ Fira Code Nerd Font
+ fcitx
+ nitrogen
+ compton
+ pulseaudio
+ pavucontrol

### system setup
To set proxy and input method, add following at `/etc/environment`:
```bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"

http_proxy="http://127.0.0.1:7890"
https_proxy="http://127.0.0.1:7890"

GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
INPUT_METHOD=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
```

### rofi setup
`launcher.sh` is required in `~/.config/rofi`.

### polybar setup
`launch.sh` is required in `~/.config/polybar`.

### multiple monitor
To setup multiple monitor, use `arandr` to generate layout file `~/.screenlayout/screen.sh`.  
If your sub-monitor dose not connect to DP-4, modify the output of workspace8-10.

## Install the latest version
```bash
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update
sudo apt install i3
```
