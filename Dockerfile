FROM alpine:3.18
LABEL maintainer="haxwithaxe"

ENV pip_packages "ansible cryptography"

# Install dependencies.
RUN apk update \
    && apk add --no-cache \
       bash \
       python3 \
       py3-pip \
       wget \
       libffi-dev \
       openssl-dev \
       procps-ng \
       py3-setuptools \
       py3-wheel \
       iproute2 \
       sudo \
    && rm -Rf /usr/share/doc \
    && rm -Rf /usr/share/man

# Upgrade pip to latest version.
RUN pip3 install --upgrade pip

# Install Ansible via pip.
RUN pip3 install $pip_packages

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
