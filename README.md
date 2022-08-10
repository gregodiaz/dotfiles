### pre-setup
curl > git > node > zsh > nvim > awesome
```bash
sudo apt install font-manager
```

# Oh my zsh
cp .oh-my-zsh .zshrc .p10k.zsh in ~/
#### create a profile:
Custom font: Operator Mono Medium Nerd Font 14 
Pallete:
```bash
#282828 #CC241D #6FA128 #D79921 #7197E7 #A77AC4 #689D6A #F2F2F2
#434343 #FB4934 #7B9729 #FABD2F #93A9D7 #B095C1 #8EC07C #F2F2F2
```
```bash
echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"
```
to reset de configure of p10k
```bash
p10k configure
```

# Awesome WM
```bash
sudo apt-get install awesome
sudo apt install compton nitrogen dmenu autorandr
```
cp awesome in ~/.config
run
```bash
xrandr --output DP-1 --mode 1366x768
```
```bash
xrandr --output DP-1 --left-to eDC1
```
```bash
autorandr -s greg
```
```bash
autorandr -d greg
```
```bash
autorandr greg
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
```
```bash
python3 -m pip install --user qmk
```
```bash
echo 'PATH="$HOME/.local/bin:$PATH"' >> $HOME/.zshrc && source $HOME/.zshrc
```
```bash
qmk setup
```
