FROM circleci/node:12.22-browsers

ENV DEBIAN_FRONTEND=noninteractive

ADD https://s3.amazonaws.com/aws-cli/awscli-bundle-1.18.223.zip awscli-bundle.zip

# ref: https://github.com/git-lfs/git-lfs/wiki/Installation#docker-recipes
RUN build_deps="" \
	&& sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends ca-certificates graphicsmagick imagemagick ghostscript fonts-noto-cjk \
    && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash \
    && sudo apt-get install -y --no-install-recommends git-lfs \
    && git lfs install \
    && sudo rm -r /var/lib/apt/lists/* \
    && sudo unzip awscli-bundle.zip \
    && sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
