FROM centos

RUN groupadd gtm && useradd -g gtm gtm && \
    yum install -y gcc libicu-devel make wget which file && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    ln -s /usr/lib64/libncurses.so.6.1 /usr/lib64/libncurses.so.5 && \
    ln -s /usr/lib64/libtinfo.so.6.1 /usr/lib64/libtinfo.so.5

ARG gtmVersion=V7.0-001
ADD install_gtm.sh /tmp/
RUN chmod +x /tmp/install_gtm.sh && /tmp/install_gtm.sh ${gtmVersion} && rm -rf /tmp/*

USER gtm

ENTRYPOINT source /opt/fis-gtm/gtmprofile && /bin/bash

