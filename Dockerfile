FROM node:stretch-slim

ENV OCTOPUS_VERSION 4.39.0

# Install CoreCLR dependencies for Octopus CLI and node-gyp
RUN apt-get update && apt-get -y install zip libunwind8 g++ build-essential python && \
        apt-get clean && rm -rf /var/lib/apt/lists/*
		
		
# Install Docker
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
	curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
	apt-get update && apt-get install -y docker-ce

RUN mkdir /opt/octo && cd /opt/octo && \
    curl -so octo.tar.gz https://download.octopusdeploy.com/octopus-tools/$OCTOPUS_VERSION/OctopusTools.$OCTOPUS_VERSION.debian.8-x64.tar.gz && \
    tar -xvf octo.tar.gz && rm -f octo.tar.gz