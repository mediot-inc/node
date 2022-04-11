FROM circleci/node:16.13-browsers

ENV DEBIAN_FRONTEND=noninteractive

ADD https://s3.amazonaws.com/aws-cli/awscli-bundle-1.18.223.zip awscli-bundle.zip

# ref: https://github.com/git-lfs/git-lfs/wiki/Installation#docker-recipes
RUN build_deps="" \
	&& sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends ca-certificates graphicsmagick imagemagick ghostscript fonts-noto-cjk build-essential \
    && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash \
    && sudo apt-get install -y --no-install-recommends git-lfs \
    && git lfs install \
    && sudo rm -r /var/lib/apt/lists/* \
    && sudo unzip awscli-bundle.zip \
    && sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# https://stackoverflow.com/questions/52998331/imagemagick-security-policy-pdf-blocking-conversion
RUN sudo sed -i '/disable ghostscript format types/,+6d' /etc/ImageMagick-6/policy.xml
