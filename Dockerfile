FROM osixia/openldap:1.1.8
MAINTAINER Kleyson Rios, krios@pentaho.com

# set env
ENV TERM xterm

# set alias
RUN echo "alias ll='ls --color=auto -la'" >> /root/.bashrc

RUN apt-get update -y

# install required softwares
RUN apt-get install -y vim net-tools telnet && \
    rm -rf /var/lib/apt/lists/*

# Enable OpenLDAP memberOf overlay
RUN echo "" >> /usr/share/slapd/slapd.conf
RUN echo "# Enable OpenLDAP memberOf overlay" >> /usr/share/slapd/slapd.conf
RUN echo "moduleload memberof.la" >> /usr/share/slapd/slapd.conf
RUN echo "overlay memberof" >> /usr/share/slapd/slapd.conf

# Copy sample to container
ADD sample.ldif /
