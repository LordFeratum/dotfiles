GREEN_COLOR='\033[0;32m'
NO_COLOR='\033[0m'

SYSTEM_REQS=./requirements/system.txt
WALLPAPER_DIR=~
I3_CONFIG_DIR=~/.config/i3/
POLYBAR_CONFIG_DIR=~/.config/polybar
NVIM_CONFIG_DIR=~/.config/nvim
FONTS_DIRECTORY=~/.local/share/fonts

echo -e "${GREEN_COLOR}Getting default monitor..."
export MONITOR=`xrandr --query | grep " connected" | awk '{ print $1}'`
echo -n "Default monitor: "
echo $MONITOR

echo -e "Installing system requirements...${NO_COLOR}"
sudo pacman -S --noconfirm - < ${SYSTEM_REQS}

echo -e "${GREEN_COLOR}Setting zsh as default shell...${NO_COLOR}"
chsh -s $(which zsh)

echo -e "${GREEN_COLOR}Instaling Oh-my-zsh...${NO_COLOR}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo -e "${GREEN_COLOR}Instaling zshrc...${NO_COLOR}"
cp dots/zsh/zshrc ~/.zshrc
source ~/.zshrc

echo -e "${GREEN_COLOR}Installing wallpaper...${NO_COLOR}"
cp dots/wallpaper.jpg ${WALLPAPER_DIR}/.wallpaper.jpg

echo -e "${GREEN_COLOR}Installing I3WM dotfiles...${NO_COLOR}"
mkdir -p ${I3_CONFIG_DIR}
cp -r dots/i3/* ${I3_CONFIG_DIR}

echo -e "${GREEN_COLOR}Installing Polybar dotfiles...${NO_COLOR}"
mkdir -p ${POLYBAR_CONFIG_DIR}
cp -r dots/polybar/* ${POLYBAR_CONFIG_DIR}

echo -e "${GREEN_COLOR}Installing Fonts...${NO_COLOR}"
mkdir -p ${FONTS_DIRECTORY}
cp -r dots/fonts/* ${FONTS_DIRECTORY}
fc-cache -fv

echo -e "${GREEN_COLOR}Installing NeoVim configuration...${NO_COLOR}"
mkdir -p ${NVIM_CONFIG_DIR}
git clone https://github.com/LordFeratum/neovimrc.git ${NVIM_CONFIG_DIR}

echo -e "${GREEN_COLOR}Installing XResources...${NO_COLOR}"
cp dots/xresources/Xresources ~/.Xresources
xrdb -merge ~/.Xresources
