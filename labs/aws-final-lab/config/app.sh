#!/bin/bash
set -e

# Actualizar paquetes e instalar nginx
sudo apt-get update -y
sudo apt-get install -y nginx

# Mensaje de prueba
echo "<h1>Hola desde $(hostname)</h1>" | sudo tee /var/www/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx
