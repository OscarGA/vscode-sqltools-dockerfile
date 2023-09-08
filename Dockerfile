# Alpine image with node 14 to run the plugin
FROM node:14-alpine3.17

# Working directory to host the git plugin code
WORKDIR /vscode-sqltools-parent
# Copy the entry point file
COPY entry_point.sh /vscode-sqltools-parent

RUN apk update 

# Download the reposity to work with, change the repo to work with 
RUN apk add git
RUN git init
RUN git submodule add https://github.com/OscarGA/vscode-sqltools.git
RUN git submodule update --init --recursive

# Intall Docker and Docker Compose
RUN apk add curl
RUN apk add --no-cache docker-cli
RUN DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
RUN mkdir -p $DOCKER_CONFIG/cli-plugins
RUN curl -SL https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
RUN chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
RUN apk add make
RUN apk add ninja
RUN apk add tar
RUN mkdir tmp
RUN chmod 777 -R tmp/
RUN curl -L https://github.com/systemd/systemd/archive/refs/tags/v254.tar.gz -o tmp/systemd-254.tar.gz
RUN tar xvf tmp/systemd-254.tar.gz -C tmp/

# Change the working directory
WORKDIR /vscode-sqltools-parent/vscode-sqltools

# Execute commands to let the plugin env ready
CMD [ "sh", "../entry_point.sh"]
