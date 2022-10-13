FROM debian:jessie-slim

LABEL maintainer="Eduardo Francellino"

RUN apt-get update && apt-get install -y gnupg software-properties-common wget \
    apt-transport-https ca-certificates

RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmon | \
    tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

RUN gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list

RUN apt update && apt-get install --force-yes -y terraform 

#CMD ["nginx", "-g", "daemon off;"]