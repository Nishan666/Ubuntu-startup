#!/bin/bash

#Basic Update
sudo apt update

sudo apt upgrade -y

#install
sudo apt install -y vlc git neofetch snapd curl wget xclip
sudo apt install -y gnome-tweaks gparted vnstat


#snap install 
sudo snap install docker
sudo snap install --classic code
sudo snap install postman
sudo snap install pgadmin4
sudo snap install chromium
sudo snap install figma-linux
sudo snap install android-studio --classic
sudo snap install blender --classic

#NodeJS using nvm (latest version)
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
if [ -n "$ZSH_VERSION" ]; then
    # zsh is detected
    source ~/.zshrc
else
    # bash or other shell
    source ~/.bashrc
fi
nvm install v22.8.0


#postgress
sudo apt install postgresql postgresql-contrib
sudo -i -u postgres

#mongodb
sudo apt-get install gnupg curl

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

sudo apt-get update

sudo apt-get install -y mongodb-org

setup_ssh=false
#Git SSH setup
if [ -z "$(ls -A ~/.ssh 2>/dev/null)" ]; then
  # Execute the code below if the directory is empty or does not exist
  echo "The ~/.ssh directory is empty or does not exist. Running the code below..."
  yes "" | ssh-keygen -t ed25519_nishan666 -C "nishankumar559@gmail.com"
  yes "" | ssh-keygen -t ed25519_jackxdot911 -C "jackxdotedge@gmail.com"
  yes "" | ssh-keygen -t rsa -b 4096 -C "nishan.kumar@7edge.com"

  eval "$(ssh-agent -s)"

  ssh-add ~/.ssh/ed25519_nishan666
  ssh-add ~/.ssh/ed25519_jackxdot911
  ssh-add ~/.ssh/id_rsa

  cat ~/.ssh/id_ed25519_nishan666.pub
  cat ~/.ssh/id_ed25519_jackxdot911.pub
  cat ~/.ssh/id_rsa.pub

  mkdir -p ~/.ssh

  cat <<EOL > ~/.ssh/config
# Azure DevOps
Host dev.azure.com
    HostName dev.azure.com
    User git
    IdentityFile ~/.ssh/id_rsa

# Default GitHub account
Host github-nishan666
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_nishan666

# Additional GitHub account (if needed)
Host github-jackxdot911
    HostName github.com
    User git 
    IdentityFile ~/.ssh/id_ed25519_jackxdot911
EOL

  chmod 600 ~/.ssh/config
  setup_ssh=true
fi


#install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
sudo apt -f install
rm -rf google-chrome-stable_current_amd64.deb

#basic folders
mkdir 7edge personal-pro nick-test


#ZSH setup
sudo apt update

sudo apt install -y zsh

echo "Setting Zsh as the default shell..."
chsh -s /usr/bin/zsh

#oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#Updating ~/.zshrc to use Powerlevel10k theme...
sed -i 's|ZSH_THEME=".*"|ZSH_THEME="powerlevel10k/powerlevel10k"|g' ~/.zshrc

sudo apt-get install -y fonts-powerline

sudo apt-get install -y dconf-cli

mkdir zsh-setup
cd zsh-setup

git clone https://github.com/dracula/gnome-terminal

cd gnome-terminal
./install.sh
cd ..

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sudo apt install -y ruby-full
sudo gem install colorls

sudo apt install -y exa

npm install -g secman

curl -sL https://cutt.ly/tran-cli | bash

{
    echo "plugins=(git zsh-syntax-highlighting zsh-autosuggestions)"
    echo "if [ -x \"\$(command -v colorls)\" ]; then"
    echo "    alias ls=\"colorls\""
    echo "    alias la=\"colorls -al\""
    echo "fi"
    echo "if [ -x \"\$(command -v exa)\" ]; then"
    echo "    alias ls=\"exa\""
    echo "    alias la=\"exa --long --all --group\""
    echo "fi"
} >> ~/.zshrc

source ~/.zshrc

echo "p10k configure"

cd
rm -rf zsh-setup
















sudo apt update
sudo apt upgrade -y
sudo rm /etc/apt/sources.list.d/mongodb-org-*.list


#final Part $$$$$NOTES$$$$
echo "NOTES"

# Conditionally display the default SSH public key if the setup is done
if [ "$setup_ssh" = true ]; then
  echo "SSH setup is complete. Displaying default SSH public key:"
  echo "Azure"
  cat ~/.ssh/id_rsa.pub
  echo "Nishan666"
  cat ~/.ssh/id_ed25519_nishan666.pub
  echo "Jackxdot911"
  cat ~/.ssh/ed25519_jackxdot911
fi
