#! /bin/bash

set -e

UBUNTU_IMAGE=ubuntu_image_01
UBUNTU_CONTAINER=ubuntu_container_01

echo We\'re in directory $PWD

cp /etc/passwd etcpasswd
cp /etc/group etcgroup
sudo cp /etc/shadow etcshadow
echo Done copying etc stuff

sudo docker build -t ${UBUNTU_IMAGE} -f Dockerfile .
echo Done building ${UBUNTU_IMAGE}

rm etcpasswd
rm etcgroup
sudo rm etcshadow

echo Done with password stuff

docker stop ${UBUNTU_CONTAINER} || true && docker rm ${UBUNTU_CONTAINER} || true

echo Stopped previous containers

docker run -it --name ${UBUNTU_CONTAINER} ${UBUNTU_IMAGE}
