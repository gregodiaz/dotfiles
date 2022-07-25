##setup
```bash
sudo apt update
sudo apt install curl
curl -sL https://deb.nodesource.com/setup_17.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs
node -v
npm -v
```
```bash
sudo apt install git
```

# Oh my zsh
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
```bash
echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"
```
```bash
sudo apt-get install fonts-powerline
cd ~/fonts
./install.sh
```
cp .zshrc in ~/
####create a profile:
Custom font: Meslo LG M for Powerline 12
Pallete:
' #282828 #CC241D #FB4934 #D79921 #7197E7 #B16286 #689D6A #FFFFFF
' #928374 #FB4934 #91912E #FABD2F #93A9D7 #D3869B #8EC07C #FFFFFF

# Awesome WM
```bash
sudo apt-get install awesome
sudo apt install compton nitrogen dmenu autorandr
```
cp awesome in ~/.config
run
```bash
xrandr --output DP-1 --left-to eDC1
xrandr --output DP-1 --mode 1366x768
autorandr -s greg2
autorandr -d greg2
autorandr greg2
```

# vim
cp nvim in ~/.config
```bash
sudo apt install neovim
sudo apt install python3-neovim
```
install Plug
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
run in vim
```bash
:PlugInstall
:CocInstall coc-prettier
```

# qmk
cp xxx in ~/qmk_firmware/keyboards/crkbd/keymaps
```bash
sudo apt install -y git python3-pip
python3 -m pip install --user qmk
echo 'PATH="$HOME/.local/bin:$PATH"' >> $HOME/.zshrc && source $HOME/.zshrc
qmk setup
```
