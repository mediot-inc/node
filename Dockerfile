FROM --platform=linux/amd64 cimg/node:24.13.1 AS aws

ENV DEBIAN_FRONTEND=noninteractive
ADD https://s3.amazonaws.com/aws-cli/awscli-bundle-1.44.36.zip awscli-bundle.zip
RUN sudo apt-get update \
   && sudo apt-get install -y --no-install-recommends unzip python3-venv \
   && sudo unzip awscli-bundle.zip \
   && sudo python3 ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
   && sudo rm -rf awscli-bundle.zip awscli-bundle \
   && sudo rm -rf /var/lib/apt/lists/*

FROM --platform=linux/amd64 cimg/node:24.13.1
ENV DEBIAN_FRONTEND=noninteractive
COPY --from=aws /usr/local/aws /usr/local/aws/
RUN sudo ln -s /usr/local/aws/bin/aws /usr/local/bin/aws

RUN sudo apt-get update \
   # chromium dependencies
   && sudo apt-get install -y --no-install-recommends \
   libnss3 \
   libatk1.0-0 \
   libatk-bridge2.0-0 \
   libgtk-3.0 \
   libdrm2 \
   libgbm1 \
   libasound2t64 \
   # other dependencies
   && sudo apt-get install -y --no-install-recommends \
   ca-certificates \
   graphicsmagick \
   imagemagick \
   ghostscript \
   fonts-noto-cjk \
   build-essential \
   cmake \
   libcairo2 \
   libcairo2-dev \
   libjpeg-dev \
   libpango1.0-dev \
   libgif-dev \
   libpixman-1-dev \
   libjpeg-turbo8-dev \
   libfreetype6-dev \
   librsvg2-dev \
   libpq-dev \
   musl \
   musl-dev \
   libpangomm-1.4-dev \
   && sudo rm -rf /var/lib/apt/lists/*

# https://stackoverflow.com/questions/52998331/imagemagick-security-policy-pdf-blocking-conversion
RUN sudo sed -i '/disable ghostscript format types/,+6d' /etc/ImageMagick-6/policy.xml

RUN sudo npx @puppeteer/browsers install --path /opt chrome@119.0.6045.105
RUN sudo ln -s /opt/chrome/linux-119.0.6045.105/chrome-linux64/chrome /usr/local/bin/google-chrome-stable
