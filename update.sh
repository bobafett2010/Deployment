#!/bin/bash

if
#apt-get
        [[ "$OSINFO" == "$APT" ]];
then
        export UPDATE="apt update";
        export UPGRADE="apt upgrade -y";
        export INSTALL="apt install -y"
elif
#pacman
        [[ "$OSINFO" == "$PAC" ]];
then
        export UPDATE="sleep 0";
        export UPGRADE="pacman -Syu --noconfirm";
        export INSTALL="pacman -S --noconfirm";
else
        echo "No Success"
fi
