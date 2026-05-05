*This project has been created as part of the 42 curriculum by ifounas.*

## Description

Inception is a project designed to learn how to create a basic Docker application. The goal is to deploy a WordPress website that can run on any PC with any configuration. Docker is used to create lightweight containers for the different services required by the application. In this project, three containers are used:
- Nginx (web server)
- MariaDB (database)
- WordPress + PHP 8.2 (content management system)

### Docker and Design Choices

**Docker** is a platform for developing, shipping, and running applications in **containers**. Unlike **Virtual Machines (VMs)**, which virtualize an entire machine including the OS, Docker containers share the host OS kernel and isolate only the application and its dependencies. This makes containers **lighter, faster to start, and more efficient** in terms of resource usage.

**Sources in the Project:**
The project includes Dockerfiles for each service (Nginx, MariaDB, WordPress) and a `docker-compose.yml` file to orchestrate the containers.

### Key Comparisons

- **Virtual Machines vs Docker:**
  VMs require a full OS per instance, leading to higher overhead. Docker containers share the host OS, making them more lightweight and portable.

- **Secrets vs Environment Variables:**
  **Environment variables** (stored in `.env`) are used for configuration and credentials in this project. While Docker Secrets provide better security for sensitive data in production, environment variables are sufficient for local development and simpler to manage in this context.

- **Docker Network vs Host Network:**
  A **Docker network** (e.g., `inception_network`) is used to allow containers to communicate with each other securely and in isolation. This is different from the **host network**, where containers share the host’s network namespace, which is less secure and not recommended for multi-container applications.

- **Docker Volumes vs Bind Mounts:**
  **Docker volumes** (e.g., `mariadb_data`, `wordpress_volume`) are used for persistent data storage. They are managed by Docker and are the preferred way to persist data in containers. **Bind mounts** link a host directory directly into a container, but volumes are more portable and better suited for production.


## Instructions

To run the application:

1. Install **Docker** and **Docker Compose**.
2. Clone the project repository.
3. At the root of the project, create a `.env` file and fill it with the following variables:
  ```ini
   DOMAIN_NAME=<your_login>.42.fr
   MYSQL_DATABASE=<change_this>
   MYSQL_USER=<change_this>
   MYSQL_ROOT_PASSWORD=<change_this>
   MYSQL_PASSWORD=<change_this>
   WORDPRESS_USER=<change_this>
   WORDPRESS_ROOT=<change_this>
   WORDPRESS_USER_PWD=<change_this>
   WP_TITLE=<change_this>
   WP_ADMIN_USER=<this_field_should_not_contain_admin>
   WP_ADMIN_PASSWORD=<change_this>
   WP_ADMIN_EMAIL=<change_this>
  ```
   **Note:** Never write your credentials in any file other than `.env`.
4. Add the following line to `/etc/hosts`:
  ```
   127.0.0.1 ifounas.42.fr
  ```
5. Now to execute the app :
  ```
  make //to execute it
  make down // to stop the app
  make fclean // to stop the app and delete all the data
  ```

## Resources

1. **Docker documentation**:
  - [Docker Compose](https://docs.docker.com/compose/)
  - [Getting Started with Docker Compose](https://docs.docker.com/compose/gettingstarted)
2. **Youtube tutorial to understand Docker**:
  - [What is Docker?](https://www.youtube.com/watch?v=DQdB7wFEygo&t=75s)
3. **Service installation documentation**:
  - Nginx: [Installation Guide](https://nginx.org/en/docs/install.html)
  - MariaDB: [Docker and MariaDB](https://mariadb.com/docs/server/server-management/automated-mariadb-deployment-and-administration/docker-and-mariadb/installing-and-using-mariadb-via-docker)
  - WordPress: [Dockerize WordPress](https://www.docker.com/blog/how-to-dockerize-wordpress/)

## AI Usage

Nowadays, it is difficult to avoid using AI for learning, understanding, or debugging. I used AI primarily to create my Dockerfiles, as they involve many installation commands, and sometimes the official documentation is not detailed enough. I also used AI to debug my containers, such as:

- Why WordPress won't start?  
-> Because we are not waiting for MariaDB to be fully launched.
- Why can't I create new posts as an admin in my WordPress website?  
-> Because Nginx does not have access to the WordPress volume.
- Why can't I access the website after restarting my containers?  
-> The user does not have all the rights to execute the commands.
- etc.

Debugging these issues can be time-consuming, so AI was a valuable tool in resolving them efficiently.