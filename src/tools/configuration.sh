echo "Git config"
git config --global user.name "David-Peralta-Rd"
git config --global user.email "crdavidperalta@gmail.com"
git config --global core.autocrlf input
git config --global --list # Check that the changes were applied.
git config --global init.defaultBranch main

# ssh key.
ssh-keygen -t ed25519 -C "crdavidperalta@gmail.com" # Create key
eval "$(ssh-agent -s)" # Add SSH agent
ssh-add ~/.ssh/id_ed25519 # Same as before.

# Conexion con ssh github
cat ~/.ssh/id_ed25519.pub # Copy key and paste into GitHub
firefox https://github.com/settings/ssh/new # Paste key into this link.
ssh -T git@github.com # Verify connection.


echo "Activar servicio de Docker"
sudo systemctl enable --now docker
sudo usermod -aG docker $USER


# Manual configuracion.
sudo nano ~/.config/kitty/hyde.conf
sudo nano ~/.config/hypr/hypridle.conf
