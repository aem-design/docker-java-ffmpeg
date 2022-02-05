## Debian with Java 8 and FFMPEG

[![build](https://github.com/aem-design/docker-java-ffmpeg/actions/workflows/build.yml/badge.svg?branch=jdk11)](https://github.com/aem-design/docker-java-ffmpeg/actions/workflows/build.yml)
[![github license](https://img.shields.io/github/license/aem-design/java-ffmpeg)](https://github.com/aem-design/java-ffmpeg) 
[![github issues](https://img.shields.io/github/issues/aem-design/java-ffmpeg)](https://github.com/aem-design/java-ffmpeg) 
[![github last commit](https://img.shields.io/github/last-commit/aem-design/java-ffmpeg)](https://github.com/aem-design/java-ffmpeg) 
[![github repo size](https://img.shields.io/github/repo-size/aem-design/java-ffmpeg)](https://github.com/aem-design/java-ffmpeg) 
[![docker stars](https://img.shields.io/docker/stars/aemdesign/java-ffmpeg)](https://hub.docker.com/r/aemdesign/java-ffmpeg) 
[![docker pulls](https://img.shields.io/docker/pulls/aemdesign/java-ffmpeg)](https://hub.docker.com/r/aemdesign/java-ffmpeg) 
[![github release](https://img.shields.io/github/release/aem-design/java-ffmpeg)](https://github.com/aem-design/java-ffmpeg)

This is docker image based on [aemdesign/oracle-jdk](https://hub.docker.com/r/aemdesign/oracle-jdk/) with AEM base libs


## Self Hosted runner

To build and deploy this repo you will need to add a self-hosted runner.

```
docker run -d --restart always --name github-runner-aemdesign -e RUNNER_NAME_PREFIX="ghraemd" -e ACCESS_TOKEN="<YOUR PERSONAL ACCESS TOKEN>" -e RUNNER_WORKDIR="/tmp/github-runner-aemdesign" -e RUNNER_GROUP="self-hosted" -e RUNNER_SCOPE="org" -e ORG_NAME="aem-design" -e LABELS="aemdesign,github-runner" -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/tmp/github-runner-your-repo myoung34/github-runner:latest
```

### Included Packages

Following is the list of packages included

* imagemagic            - for converting assets
* libx                  - for forms processing
* buildtools            - for building xvid
* xvid            - for building xvid

