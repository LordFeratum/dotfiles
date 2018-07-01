SYSTEM_REQS=./requirements/system.txt
WALLPAPER_DIR=~
I3_CONFIG_DIR=~/.config/i3/
POLYBAR_CONFIG_DIR=~/.config/polybar
FONTS_DIRECTORY=~/.local/share/fonts

echo "Getting default monitor..."
export MONITOR=`xrandr --query | grep " connected" | awk '{ print $1}'`
echo -n "Default monitor: "
echo $MONITOR

echo "Installing system requirements..."
sudo pacman -S --noconfirm - < ${SYSTEM_REQS}

echo "Setting zsh as default shell..."
chsh -s $(which zsh)

echo "Instaling Oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Instaling zshrc..."
cp dots/zsh/zshrc ~/.zshrc
source ~/.zshrc

echo "Installing wallpaper..."
cp dots/wallpaper.jpg ${WALLPAPER_DIR}/.wallpaper.jpg

echo "Installing I3WM dotfiles..."
mkdir -p ${I3_CONFIG_DIR}
cp -r dots/i3/* ${I3_CONFIG_DIR}

echo "Installing Polybar dotfiles..."
mkdir -p ${POLYBAR_CONFIG_DIR}
cp -r dots/polybar/* ${POLYBAR_CONFIG_DIR}

echo "Installing Fonts..."
mkdir -p ${FONTS_DIRECTORY}
cp -r dots/fonts/* ${FONTS_DIRECTORY}
fc-cache -fv
