#!/bin/bash
# _*_ coding: utf-8 _*_

echo
cd ~
mkdir .termux
cd .termux
curl https://raw.githubusercontent.com/Kmb-id/Terkey/refs/heads/main/termux.properties -o termux.properties
cd ~
termux-reload-settings
