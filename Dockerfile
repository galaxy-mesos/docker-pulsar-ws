# Pulsar Web Server

# Download base image ubuntu 16.04
FROM ubuntu:16.04

# Define the ENV variable
ENV container docker
ARG DEBIAN_FRONTEND=noninteractive

# Install pulsar
RUN apt-get update
RUN apt-get install -y apt-utils vim
RUN apt-get install -y python-dev python-pip
RUN apt-get install -y libffi-dev libssl-dev
RUN pip install --upgrade pip
RUN pip install pyOpenSSL
RUN pip install virtualenv
RUN mkdir -p /pulsar
RUN virtualenv /pulsar/venv
RUN . /pulsar/venv/bin/activate; pip install pulsar-app; pulsar-config

# Avoid message: invoke-rc.d: policy-rc.d denied execution of start.
RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

# Configure Port
EXPOSE 8913

#CMD cd pulsar
CMD  . /pulsar/venv pulsar --daemon

