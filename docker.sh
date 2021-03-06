#!/bin/bash

source vari

echo "Preparing to install Docker Engine"

while true; do
  read -p "Do you want to install Docker Engine on this system? y/n >> " YN
  case ${YN:0:1} in
    [Yy]* )
      if
        [[ "$OSINFO" == "$APT" ]];
      then
        echo "Uninstalling old versions";
        sudo apt remove docker docker-engine docker.io containerd runc;
        sudo apt update;
        sudo apt install ca-certificates curl gnupg lsb-release;
        sudo mkdir -p /etc/apt/keyrings;
        RELEASE=$(lsb_release -a | grep -o -i "ubuntu\|debian" | uniq | tr [:upper:] [:lower:]);
        curl -fsSL https://download.docker.com/linux/$RELEASE/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg;
        echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$RELEASE \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
        sudo apt update;
        sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin;
        echo "Done"
      elif
        [[ "$OSINFO" == "$PAC" ]];
      then
        sudo pacman -Syu --noconfirm;
        sudo pacman -S docker --nnoconfirm;
        sudo systemctl start docker;
        sudo systemctl enable docker;
      else
        echo "Skipping...";
      fi
      break;;
    [Nn]* )
      echo "Skipping..."
      break;;
    * )
      echo "Please answer either Y/y or N/n";;
  esac
done

echo "Docker setup finished"
