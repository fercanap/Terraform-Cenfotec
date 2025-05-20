#!/bin/bash -x

sudo apt update
sudo apt install nginx -y

echo "$last_var" >> /home/ubuntu1/hello2.txt
