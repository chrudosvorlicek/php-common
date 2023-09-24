FROM php:8.2.10-cli-bookworm

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=liteacz/whalesome:v0.0.1-alpha.1 /opt/whalesome /opt/whalesome

COPY ./shared.sh /usr/local/bin/shared

RUN echo "Installing shared dependencies" \
    && mv /opt/whalesome/bin/* /usr/local/bin \
    && chmod +x /usr/local/bin/shared \
    && /usr/local/bin/shared

ENV LANG cs_CZ.UTF-8
ENV LC_ALL cs_CZ.UTF-8

WORKDIR /var/www

ENTRYPOINT ["docker-entrypoint"]
