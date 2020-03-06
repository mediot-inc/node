FROM circleci/node:10.11-browsers

ADD https://s3.amazonaws.com/aws-cli/awscli-bundle.zip awscli-bundle.zip
RUN sudo unzip awscli-bundle.zip && sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# ref: https://github.com/git-lfs/git-lfs/wiki/Installation#docker-recipes
RUN build_deps="curl" && \
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y --no-install-recommends ${build_deps} ca-certificates && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash && \
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y --no-install-recommends git-lfs && \
    git lfs install && \
    DEBIAN_FRONTEND=noninteractive sudo apt-get purge -y --auto-remove ${build_deps} && \
    sudo rm -r /var/lib/apt/lists/*
