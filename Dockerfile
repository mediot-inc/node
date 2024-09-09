FROM mediot/node:20.10-browsers-awscli-cjk
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends libcairo2 libcairo2-dev libjpeg-dev libpango1.0-dev musl-dev libgif-dev libpixman-1-dev libpangomm-1.4-dev libjpeg-turbo8-dev libfreetype6-dev librsvg2-dev musl

RUN sudo rm -rf /usr/local/bin/npm /usr/local/share/man/man1/node* /usr/local/lib/dtrace/node.d ~/.npm ~/.node-gyp /opt/local/bin/node opt/local/include/node /opt/local/lib/node_modules \
   && sudo rm -rf /usr/local/lib/node* \
   && sudo rm -rf /usr/local/include/node* \
   && sudo rm -rf /usr/local/bin/node* \
   && wget https://nodejs.org/dist/v22.8.0/node-v22.8.0-linux-x64.tar.xz \
   && sudo tar --xz -xf node-v22.8.0-linux-x64.tar.xz -C /usr/local --strip-components=1 \
   && rm node-v22.8.0-linux-x64.tar.xz
