if [ -x "$(command -v docker)" ]; then
    echo "bout to pull ur image"
    sudo docker pull jahaplace/node-test
    echo "runnin the container bruh..."
    sudo docker run -d -p 80:8080 jahaplace/node-test
else
    echo "finna update apt..."
    sudo apt update
    echo "finna install docker"
    sudo apt install docker
    sudo apt install docker.io
    echo "finna pull ur image"
    sudo docker pull jahaplace/node-test
    echo "runnin the container bruh..."
    sudo docker run -d -p 80:8080 jahaplace/node-test
fi