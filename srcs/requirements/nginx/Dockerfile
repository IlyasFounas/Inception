# syntax=docker/dockerfile:1
FROM debian:13.0

# install app dependencies
RUN apt update -y
RUN apt install -y curl gnupg ca-certificates lsb-release debian-archive-keyring
RUN curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
https://nginx.org/packages/debian `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list

RUN apt update -y
RUN apt install nginx -y

# finish the init
COPY srcs/requirements/nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

# run the image
CMD ["nginx", "-g", "daemon off;"]