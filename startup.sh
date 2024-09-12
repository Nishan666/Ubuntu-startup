#!/bin/bash

cd ~/

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
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if [ -n "$ZSH_VERSION" ]; then
    # zsh is detected
    source ~/.zshrc
else
    # bash or other shell
    source ~/.bashrc
fi
nvm install v22.8.0
nvm alias default v22.8.0


#postgress
sudo apt install -y postgresql postgresql-contrib
sudo -i -u postgres

#mongodb
sudo apt install -y gnupg curl

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

sudo apt-get update

sudo apt-get install -y mongodb-org

#Git SSH setup
setup_ssh=false

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


#ZSH setup
sudo apt update

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if [ -n "$ZSH_VERSION" ]; then
    # zsh is detected
    source ~/.zshrc
else
    # bash or other shell
    source ~/.bashrc
fi
nvm install v22.8.0
nvm alias default v22.8.0

# Update and install Zsh and required packages
echo "Installing Zsh and required packages..."
sudo apt update -y
sudo apt install -y zsh curl git npm

# Change the default shell to Zsh for the current user
echo "Setting Zsh as the default shell..."
chsh -s $(which zsh) $(whoami)

# Install Oh My Zsh without exiting the shell
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Powerlevel10k theme for Oh My Zsh
echo "Installing Powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Update ~/.zshrc to use Powerlevel10k theme
echo "Configuring Powerlevel10k theme..."
sed -i 's|^ZSH_THEME=".*"|ZSH_THEME="powerlevel10k/powerlevel10k"|g' ~/.zshrc

# Install additional packages
echo "Installing additional packages..."
sudo apt-get install -y fonts-powerline dconf-cli ruby-full exa

# Install MesloLGS NF font for Powerlevel10k
echo "Installing MesloLGS NF font..."
# Create the fonts directory if it doesn't exist
mkdir -p ~/.local/share/fonts
# Download the MesloLGS NF font files
cd ~/.local/share/fonts
curl -fLo "MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -fLo "MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -fLo "MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -fLo "MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
# Go back to the home directory
cd ~/
# Refresh font cache
echo "Refreshing font cache..."
fc-cache -f -v
# Set the font in GNOME Terminal profile
PROFILE_IDS=$(gsettings get org.gnome.Terminal.ProfilesList list | grep -oP "'\K[^']+")
# Iterate through each profile ID
for PROFILE_ID in $PROFILE_IDS; do
    # Remove any trailing or leading characters like ] or '
    PROFILE_ID=$(echo "$PROFILE_ID" | sed "s/[\']\|[\[]//g")
    echo "Setting MesloLGS NF font for profile ID: $PROFILE_ID..."
    echo $PROFILE_ID
    # Set the font for the current profile ID
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/" font 'MesloLGS NF Regular 11'
    
    echo "Font configuration complete for profile ID: $PROFILE_ID"
done
echo "Font installation and configuration complete for all profiles."

#for default user
DEFAULT_PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
echo "Setting MesloLGS NF font for the default profile..."
echo $DEFAULT_PROFILE_ID
# Set the font for the default profile ID
gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$DEFAULT_PROFILE_ID/" font 'MesloLGS NF Regular 11'
echo "Font installation and configuration complete for the default profile."


# Install Ruby gems and npm packages
echo "Installing Ruby gems and npm packages..."
sudo gem install colorls
npm install -g secman

# Install Tran CLI
echo "Installing Tran CLI..."
curl -sL https://cutt.ly/tran-cli | bash

# Clone and install Dracula theme for GNOME Terminal
echo "Installing Dracula theme for GNOME Terminal..."
mkdir -p ~/zsh-setup
cd ~/zsh-setup
git clone https://github.com/dracula/gnome-terminal
cd gnome-terminal
echo -e "2\n" | ./install.sh --scheme Dracula --profile Default --confirm

# Clone Zsh plugins
echo "Cloning Zsh plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Add configuration to ~/.zshrc for plugins and aliases
echo "Configuring Zsh plugins and aliases..."
{
    echo "plugins=(git zsh-syntax-highlighting zsh-autosuggestions)"
    echo "source \${ZSH_CUSTOM:-\$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    echo "source \${ZSH_CUSTOM:-\$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    echo "if [ -x \"\$(command -v colorls)\" ]; then"
    echo "    alias ls=\"colorls\""
    echo "    alias la=\"colorls -al\""
    echo "fi"
    echo "if [ -x \"\$(command -v exa)\" ]; then"
    echo "    alias ls=\"exa\""
    echo "    alias la=\"exa --long --all --group\""
    echo "fi"
} >> ~/.zshrc

# Set up Powerlevel10k configuration
echo "Setting up Powerlevel10k configuration..."
cd ~/
wget -O ~/.p10k.zsh https://raw.githubusercontent.com/Nishan666/Ubuntu-startup/main/.p10k.zsh
cat ~/.p10k.zsh

# Ensure .zshrc sources Powerlevel10k configuration
echo "source ~/.p10k.zsh" >> ~/.zshrc


# Clean up setup files
echo "Cleaning up setup files..."
cd ~/
rm -rf ~/zsh-setup

# Apply changes to current session
echo "Applying changes to the current session..."
zsh
source ~/.zshrc

echo "Zsh setup complete! Please restart your terminal or open a new terminal session to apply changes."

#basic folders
mkdir 7edge personal-pro nick-test


















sudo apt update
sudo apt upgrade -y
sudo rm /etc/apt/sources.list.d/mongodb-org-*.list
cd ~/
rm -rf startup.sh

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


echo "reboot"
