FROM debian:13.0

# Install app dependencies
RUN apt update -y
RUN apt install -y curl gnupg ca-certificates lsb-release debian-archive-keyring
RUN curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
https://nginx.org/packages/debian `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list

RUN apt update -y
RUN apt install nginx -y

# Create the folder for the certificats
RUN mkdir -p /etc/nginx/ssl

COPY certif_ssl.sh /docker-entrypoint.d/
RUN chmod +x /docker-entrypoint.d/certif_ssl.sh

COPY default.conf /etc/nginx/conf.d/default.conf

RUN echo "#!/bin/sh" > /docker-entrypoint.sh && \
    echo "/docker-entrypoint.d/certif_ssl.sh" >> /docker-entrypoint.sh && \
    echo "nginx -g 'daemon off;'" >> /docker-entrypoint.sh && \
    chmod +x /docker-entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/docker-entrypoint.sh"]