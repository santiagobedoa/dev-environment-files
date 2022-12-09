#!/bin/bash

if [ "$(id -u)" != "0" ]
then
	echo "Sorry, you are not root."
	exit 1
fi

echo "The following items will be installed"

echo "✅   Install Homebrew"
echo "✅   Install iterm2"
echo "✅   Install git"
echo "✅   Install OhMyZsh"
echo "✅   Install powerlevel10k"
echo "✅   Install Neovim"
echo "✅   Install Neovim plugins"
echo "✅   Install nvm and Nodejs"
echo "✅   Install tmux"
echo ""
echo "  Made by @santiagobedoa  "
echo ""
read -p 'Would you like to continue? [y/n] ' YES

if [ $YES == 'y' ]
then
	continue
else
	exit
fi

# Go to root
cd ~

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/scratch/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/scratch/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install iterm2
echo -e "Installing iterm2..."
brew install --cask iterm2

# installing git
echo -e "Installing git..."
brew install git

# Installing OhMyZsh
echo -e "Installing OhMyZsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k
echo -e "Installing powerlevel10k"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Install Neovim
brew install neovim

# Install my preference files config
git clone https://github.com/santiagobedoa/dev-environment-files.git
mv dev-environment-files/.zshrc ./
# check if .config dir exists
if [ ! -d ".config"]
then
  mkdir .config
fi
mv dev-environment-files/nvim .config/

#iterm2 theme colors
curl https://raw.githubusercontent.com/josean-dev/dev-environment-files/main/coolnight.itermcolors --output ~/Downloads/coolnight.itermcolors

# zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install node
nvm install node
nvm use node

# Install tmux
brew install tmux
mv dev-environment-files/.tmux.conf ./


echo -e "PENDING..."
echo -e "run p10k congigure to configure powerlevel10k"
echo -e "configure iterm2 preferences"
echo -e "make available plugins by doing: nvim ./config/nvim/lua/plugins-setup.lua"
echo -e "once open, :w an plugins automatically will download the plugins"
echo -e "setup Mason: nvim, then type :Mason"
echo -e "setup tmux by creating a session and type ctr+a I"
