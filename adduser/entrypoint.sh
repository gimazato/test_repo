#!/bin/bash -e

# create group
if [ x"GROUP_ID" != x"0" ]; then
    groupadd -g $USER_GROUP $USER_NAME
fi

# create user
if [ x"USER_ID" != x"0" ]; then
    useradd -d /home/$USER_NAME -m -s /bin/bash -u $USER_ID -g $USER_GROUP $USER_NAME
    echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER_NAME}

fi

exec $@