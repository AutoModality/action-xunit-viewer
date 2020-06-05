# Container image that runs your code
FROM node:lts-alpine

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY detection.sh /detection.sh

RUN npm i -g xunit-viewer

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]