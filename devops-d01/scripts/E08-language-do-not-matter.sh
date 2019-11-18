#!/usr/bin/env bash

clear
echo "\n\n---------------------------------"
echo "Begin of script"
echo "---------------------------------"
echo "\n\n---------------------------------"
echo "Build container"
echo "---------------------------------"
sudo docker build -t registry.efrei.yayo.fr/louisadam/devops-d01/hellogo:latest .

echo "\n\n---------------------------------"
echo "Run container"
echo "---------------------------------"
sudo docker run -d -p 1234:8080 -e HELLO_WHAT="louisadam" --name mygo registry.efrei.yayo.fr/louisadam/devops-d01/hellogo:latest
sudo docker exec -it mygo "./main"

echo "\n\n---------------------------------"
echo "Check if the container is created"
echo "---------------------------------"

sudo docker ps -a
echo "\n\n---------------------------------"
echo "try this command: 'curl localhost:8080'"
echo "---------------------------------"
curl localhost:1234
echo "\n\n---------------------------------"
echo "Check if the container is removed"
echo "---------------------------------"
sudo docker rm mynode -f
sudo docker ps -a
echo "\n\n---------------------------------"
echo "End of script"
echo "---------------------------------\n\n"
