FROM blitznote/debootstrap-amd64:16.04 

RUN \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && perl -pi -e 's/archive.ubuntu.com/us.archive.ubuntu.com/' /etc/apt/sources.list \
    && perl -pi -e 's/amd64/i386,amd64/' /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get dist-upgrade --allow-change-held-packages --ignore-hold --assume-yes

RUN \
    apt-get install -y \
    lsb-base lsb-release sudo build-essential git aptitude

ADD https://chromium.googlesource.com/chromium/src/+/master/build/install-build-deps.sh?format=TEXT /tmp/install-build-deps.sh.b64

RUN \
    base64 -d < /tmp/install-build-deps.sh.b64 > /tmp/install-build-deps.sh \
    && chmod +x /tmp/install-build-deps.sh \
    && perl -pi -e 's/bash -e/bash -ve/' /tmp/install-build-deps.sh \
    && perl -pi -e 's/if new_list.*/new_list=\$packages\nif false; then/' /tmp/install-build-deps.sh \
    && sed -i -e '/^  new_list/,+2d' /tmp/install-build-deps.sh \
    && perl -pi -e 's/apt-get install \$\{do_quietly-}/aptitude install --assume-yes/' /tmp/install-build-deps.sh \
    && cat /tmp/install-build-deps.sh \
    && /tmp/install-build-deps.sh --no-prompt --no-chromeos-fonts --no-nacl --no-arm

RUN \
    mkdir -p /chromium \
    && cd / \
    && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

RUN \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH=$PATH:/depot_tools
