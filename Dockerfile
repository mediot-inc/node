FROM cimg/node:22.7.0-browsers

ENV DEBIAN_FRONTEND=noninteractive

ADD https://s3.amazonaws.com/aws-cli/awscli-bundle-1.18.223.zip awscli-bundle.zip

# ref: https://github.com/git-lfs/git-lfs/wiki/Installation#docker-recipes
RUN build_deps="" \
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmour -o /usr/share/keyrings/chrome-keyring.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list \
	&& sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends ca-certificates graphicsmagick imagemagick ghostscript fonts-noto-cjk build-essential cmake python3.10-venv google-chrome-stable libcairo2 libcairo2-dev libjpeg-dev libpango1.0-dev musl-dev libgif-dev libpixman-1-dev libpangomm-1.4-dev libjpeg-turbo8-dev libfreetype6-dev librsvg2-dev musl socat \
    && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash \
    && sudo apt-get install -y --no-install-recommends git-lfs \
    && git lfs install \
    && sudo rm -r /var/lib/apt/lists/* \
    && sudo unzip awscli-bundle.zip \
    && sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# https://stackoverflow.com/questions/52998331/imagemagick-security-policy-pdf-blocking-conversion
RUN sudo sed -i '/disable ghostscript format types/,+6d' /etc/ImageMagick-6/policy.xml
