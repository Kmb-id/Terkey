#!/bin/bash
# _*_ coding: utf-8 _*_

echo -e ("installing . . . ") 
(cd ~/;mkdir .termux;cd .termux;curl https://raw.githubusercontent.com/Kmb-id/Terkey/refs/heads/main/termux.properties -o termux.properties;cd ~/;termux-reload-settings) &> /dev/null
echo -e ("Sukses \n Please Restart your Termux") 
