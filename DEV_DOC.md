# Developer Documentation

This document explains how to set up, build, and manage the Inception project from a developer perspective.

---

## Set Up the Environment

### Prerequisites

- **Docker** and **Docker Compose** must be installed on your system.
- A Unix-based terminal (Linux/macOS) is recommended.

### Configuration Files

- `**.env**`: Contains all environment variables required for the project (database credentials, WordPress admin credentials, domain name, etc.). This file must be created at the root of the project.
- `**docker-compose.yml**`: Defines the services, networks, and volumes for the Docker containers.
- **Dockerfiles**: Each service (Nginx, MariaDB, WordPress) has its own `Dockerfile` in the `srcs/requirements/<service>` directory.

### Secrets

- Sensitive data (passwords, credentials) are stored as environment variables in the `.env` file. **Never commit this file to version control.**

---

## Build and Launch the Project

### Using the Makefile

The project includes a `Makefile` to simplify common tasks:

- **Build and start the containers**:
  ```bash
  make
  ```
- **Stop the containers**:
  ```bash
  make down
  ```
- **Stop and remove containers, networks, and volumes (clean all data)**:
  ```bash
  make fclean
  ```
- **Rebuild the containers without cache**:
  ```bash
  make rebuild
  ```
- **Stop a specific service**:
  ```bash
  make stop-<service>  # e.g., make stop-mariadb
  ```

### Using Docker Compose Directly

- **Build and start the containers**:
  ```bash
  docker-compose up -d --build
  ```
- **Stop the containers**:
  ```bash
  docker-compose down
  ```
- **View logs for all services**:
  ```bash
  docker-compose logs -f
  ```
- **View logs for a specific service**:
  ```bash
  docker-compose logs -f <service>  # e.g., docker-compose logs -f mariadb
  ```

---

## Manage Containers and Volumes

### Containers

- **List running containers**:
  ```bash
  docker ps
  ```
- **List all containers (including stopped ones)**:
  ```bash
  docker ps -a
  ```
- **Restart a container**:
  ```bash
  docker restart <container_name>
  ```
- **Access a container shell**:
  ```bash
  docker exec -it <container_name> /bin/bash
  ```

### Volumes

- **List all volumes**:
  ```bash
  docker volume ls
  ```
- **Inspect a volume**:
  ```bash
  docker volume inspect <volume_name>
  ```
- **Remove a volume**:
  ```bash
  docker volume rm <volume_name>
  ```

---

## Data Storage and Persistence

### Where Data is Stored

- **MariaDB data**: Stored in a Docker volume named `db` (or a bind mount, depending on your `docker-compose.yml` configuration).
- **WordPress data**: Stored in a Docker volume named `wordpress_volume` (or a bind mount).
- **Nginx configuration**: Stored in the `srcs/requirements/nginx` directory and copied into the Nginx container.

### How Data Persists

- **Docker Volumes**: Used for persistent data (e.g., MariaDB database, WordPress files). Volumes are managed by Docker and survive container restarts or recreations.
- **Bind Mounts**: If configured, bind mounts link a host directory directly into a container (e.g., for development purposes). Changes on the host are immediately reflected in the container and vice versa.