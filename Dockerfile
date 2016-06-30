FROM ubuntu:trusty
MAINTAINER Boris Gorbylev <ekho@ekho.name>

# Version Toran Proxy
ENV TORAN_PROXY_VERSION 1.5.1

# Install software
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
    ca-certificates \
    software-properties-common \
 && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
 && apt-get update \
 && apt-get install -y \
    curl \
    daemontools \
    git \
    net-tools \
    nginx \
    php-cli \
    php-curl \
    php-fpm \
    php-intl \
    php-json \
    php-xml \
    ssh \
    supervisor \
    unzip \
    wget \
  && apt-get autoremove -y \
  && apt-get autoclean all \
  && rm -rf /var/lib/apt/lists/*

COPY scripts /scripts/toran-proxy/
COPY assets/supervisor/conf.d /etc/supervisor/conf.d/
COPY assets/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY assets/vhosts /etc/nginx/sites-available
COPY assets/config /assets/config

RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
 && curl -sL https://toranproxy.com/releases/toran-proxy-v${TORAN_PROXY_VERSION}.tgz | tar xzC /tmp \
 && mv /tmp/toran /var/www \
 && chmod -R u+x /scripts/toran-proxy

ENV PATH $PATH:/scripts/toran-proxy

VOLUME /data/toran-proxy

EXPOSE 80 443 9418

CMD /scripts/toran-proxy/launch.sh
