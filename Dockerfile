FROM ghcr.io/actions/actions-runner:2.311.0

# renovate: datasource=repology depName=ubuntu_22_04/curl versioning=loose
ARG CURL_VER=7.81.0-1ubuntu1.14
# renovate: datasource=repology depName=ubuntu_22_04/git-lfs versioning=loose
ARG GIT_LFS_VER=3.0.2-1ubuntu0.2
# renovate: datasource=repology depName=ubuntu_22_04/unzip versioning=loose
ARG UNZIP_VER=6.0-26ubuntu3.1

# renovate: datasource=docker depName=gcr.io/google.com/cloudsdktool/google-cloud-cli
ARG GOOGLE_VER=454.0.0
ARG GOOGLE_DIR=/usr/local/google-cloud-sdk

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
        "curl=$CURL_VER" \
        "git-lfs=$GIT_LFS_VER" \
        "unzip=$UNZIP_VER" \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 # gcloud
 && mkdir -p "$GOOGLE_DIR" \
 && curl \
        --location \
        "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${GOOGLE_VER}-linux-x86_64.tar.gz" \
        | tar xz --directory "$GOOGLE_DIR" --strip-components 1

ENV PATH="${PATH}:${GOOGLE_DIR}/bin"

USER runner
