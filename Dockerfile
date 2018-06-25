FROM ubuntu:18.04

# CREATE DIRECTORY
WORKDIR /usr/src/hubot

# INSTALL DEPENDENCIES
RUN apt-get update; apt-get install nodejs npm redis git git-core -y

# CLONE APP AND RUN NPM INSTALL
RUN git clone https://github.com/jonfairbanks/Halbert .

CMD ["sh", "-c", "./bin/hubot --adapter slack" ]
