#grant docker permission to connect with the xserver.
xhost +local:docker

#create a volume so that storage persists
docker volume create gbo-vol

docker run --name grim-container \
    --mount type=volume,src=gbo-vol,target=/home \
    -it \
    --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --volume /dev/shm:/dev/shm \
    grim 
