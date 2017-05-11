FROM ubuntu:16.10

ENV PHANTOMJS_VERSION phantomjs-2.1.1-linux-x86_64
ENV PHANTOMJS_FILE    phantomjs-2.1.1-linux-x86_64.tar.bz2
ENV NVM_VERSION       v0.33.1
ENV NVM_DIR           /root/.nvm/versions/node
ENV NODE_VERSION      7.9.0

RUN apt-get update && apt-get upgrade -y \
 && apt install -y git curl bzip2 libfontconfig python \
 && curl -OL "https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOMJS_FILE" \
 && tar jxf "$PHANTOMJS_FILE" \
 && install "$PHANTOMJS_VERSION/bin/phantomjs" /usr/local/bin \
 && rm -rf "$PHANTOMJS_VERSION" \
 && rm "$PHANTOMJS_FILE" \
 && curl -o- "https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh" | bash \
 && . ~/.bashrc \
 && nvm install $NODE_VERSION \
 && nvm alias default $NODE_VERSION \
 && nvm use default \
 && echo "Installing NPM global packages" \
 && npm i -g casperjs --silent \
 && apt-get autoremove

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

WORKDIR /app
ADD ./package.json ./index.js /app/
CMD ["npm", "start"]