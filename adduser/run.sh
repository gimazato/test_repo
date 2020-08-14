USER_ID=$(id -u)
USER_GROUP=$(id -g)
USER_NAME=docker_$(id -u -n)

docker run \
    --rm -it \
    -e USER_ID=$USER_ID \
    -e USER_GROUP=$USER_GROUP \
    -e USER_NAME=$USER_NAME \
    -v $HOME/test:/work \
    ubuntu:add_test \
    su $USER_NAME