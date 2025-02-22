ARG WHITELISTER_VERSION="1.6.3"
ARG NODE_VERSION=18
#ARG YARN_VERSION=1.22 # For doc purposes yarn is already installed.


# Stage 1: Build environment
FROM node:${NODE_VERSION} AS build

WORKDIR /app

# Make ARG available for run command.
ARG WHITELISTER_VERSION
ENV WHITELISTER_VERSION="${WHITELISTER_VERSION}"

RUN echo "Squad_Whitelister Version: $WHITELISTER_VERSION" && \
    echo "Node Version: $NODE_VERSION"

RUN curl -L -o Whitelister.zip "https://github.com/fantinodavide/Squad_Whitelister/archive/refs/tags/V${WHITELISTER_VERSION}.zip" && \
    unzip Whitelister.zip && \
    mv Squad_Whitelister-${WHITELISTER_VERSION} Whitelister && \
    ls -lah && \
    rm Whitelister.zip && \
    npm --cwd="./Whitelister/release" --ignore-optional install


# Stage 2: Production environment
FROM node:${NODE_VERSION}-slim AS prod

LABEL maintainer="Comunidad Hispana de Squad"
LABEL version=${WHITELISTER_VERSION}
LABEL description="Production ready docker container for Squad_Whitelister"

WORKDIR /app

# Copy necessary files from the build stage
COPY --from=build /app/Whitelister/release ./

RUN npm install -g pm2

CMD ["pm2-runtime", "start", "server.js"]
