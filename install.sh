#!/usr/bin/env zsh

sudo apt install -y pip

python3 -m pip install apio==0.6.7

echo 'PATH="/home/dabo/.local/bin:$PATH"' >> ~/.zprofile
PATH="/home/dabo/.local/bin:$PATH"

apio install --all

# ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="0666", GROUP="plugdev", TAG+="uaccess"
