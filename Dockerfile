FROM node:14-alpine3.17

WORKDIR /vscode-sqltools-parent
COPY entry_point.sh /vscode-sqltools-parent

RUN apk update && apk add git
RUN git init
RUN git submodule add https://github.com/mtxr/vscode-sqltools.git
RUN git submodule update --init --recursive

WORKDIR /vscode-sqltools-parent/vscode-sqltools

CMD [ "sh", "../entry_point.sh"]
