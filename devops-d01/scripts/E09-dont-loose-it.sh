#!/usr/bin/env bash

case $# in
    1)
        case $1 in
        build)
            echo "\n---------------------------------"
            echo "Build container"
            echo "---------------------------------"
            sudo docker build -t registry.efrei.yayo.fr/louisadam/devops-d01/hellonode:latest .
            ;;
        run)
            echo "\n---------------------------------"
            echo "Run container"
            echo "---------------------------------"
            sudo docker run -d -p 1234:8080 -v $PWD:/app --name mynode registry.efrei.yayo.fr/louisadam/devops-d01/hellonode:latest
            ;;
        log)
            sudo docker logs mynode
            ;;
        destroy)
            sudo docker rm -f mynode
            sudo docker rmi -f registry.efrei.yayo.fr/louisadam/devops-d01/hellonode:latest
            ;;
        esac
        ;;
    0)
        echo "\n---------------------------------"
        echo "Usage:"
        echo "\t build: build the container"
        echo "\t run: run the container"
        echo "\t log: display the container's logs"
        echo "\t destroy: destroy the container and the image"
        echo "---------------------------------"
        ;;
esac