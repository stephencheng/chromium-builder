# About chromium-builder

The [chromium-builder](https://github.com/knq/chromium-builder) project
provides a Docker image, [`knqz/chromium-builder`](https://hub.docker.com/r/knqz/chrome-headless/),
suitable for use as an environment for building the Chromium source tree.

This was created in order to automate builds/deployments of `headless_shell`
for use with the Docker [`chrome-headless`](https://github.com/knq/chrome-headless) image.

## Running

You can use this Docker image in the usual way:

```sh
# updated to latest version of chromium-builder
$ docker pull knqz/chromium-builder

# build latest chrome version
$ docker run -it -v /path/to/chromium:/chromium -v /path/to/build:/build --rm knqz/chromium-builder /build/build.sh

# build specific tag
$ docker run -it -v /path/to/chromium:/chromium -v /path/to/build:/build --rm knqz/chromium-builder /build/build.sh 58.0.3006.3
```

## Building Image

The Docker image can be manually built the usual way:

```sh
$ cd /path/to/chromium-builder && docker build -t chromium-builder .
```
