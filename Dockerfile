FROM ubuntu:18.04

MAINTAINER https://github.com/jonfairbanks/Halbert

# CREATE DIRECTORY
WORKDIR /usr/src/hubot

# INSTALL DEPENDENCIES
RUN apt-get update; apt-get install nodejs npm redis git git-core -y

# CLONE APP AND RUN NPM INSTALL
RUN git clone https://github.com/jonfairbanks/Halbert .

# EXPOSE A VOLUME
VOLUME /halbert

CMD ["sh", "-c", "./bin/hubot --adapter slack"]
