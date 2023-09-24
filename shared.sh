#!/usr/bin/env sh

echo "Installing shared dependencies" \
  && echo "Installing laravel preset" \
  && apt-get update \
  && apt-get install -y libtool wget libpng-dev zlib1g-dev libzip-dev \
                        libfreetype6-dev libjpeg62-turbo-dev libgd-dev \
                        libonig-dev libpq-dev libicu-dev ghostscript \
                        python3-pip htop less iproute2 libboost-all-dev sqlite3 locales chromium \
  && localedef -i cs_CZ -c -f UTF-8 -A /usr/share/locale/locale.alias cs_CZ.UTF-8 \
  && apt-get install -y $PHPIZE_DEPS\
  && lit preset laravel \
  && lit install php/composer \
  && echo "Installing swoole extension (required by Octane)" \
  && pecl install swoole \
  && docker-php-ext-enable swoole\
  && echo "Installing php extensions" \
  && docker-php-ext-install iconv pcntl zip gd mbstring intl pdo_pgsql sockets\
  && echo "Clean apt cache" \
  && apt-get clean \
  && apt-get autoclean \
  && rm -rf /var/cache/apt/* \
  && wget -O "/usr/local/bin/local-php-security-checker" "https://github.com/fabpot/local-php-security-checker/releases/download/v2.0.4/local-php-security-checker_2.0.4_linux_amd64" \
  && chmod a+x /usr/local/bin/local-php-security-checker \
  && pip3 install supervisor

