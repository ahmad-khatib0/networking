sudo apt-get update && sudo apt-get upgrade

yes | sudo apt install vim
yes | sudo apt install network-manager
sudo systemctl start NetworkManager.service
sudo systemctl enable NetworkManager.service
