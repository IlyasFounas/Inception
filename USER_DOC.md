# User Documentation

This document explains how to use and manage the Inception project stack.

---

## Services Provided

The stack includes the following services:

- **Nginx**: Web server handling HTTPS requests.
- **MariaDB**: Database server for WordPress data storage.
- **WordPress + PHP 8.2**: Content management system for creating and managing website content.

---

## Start and Stop the Project

After following the installation instructions in the [README.md](README.md):

- **Start the application**:
  ```bash
  make
  ```
- **Stop the application**:
  ```bash
  make down
  ```
- **Stop the application and clean all data**:
  ```bash
  make fclean
  ```

---

## Access the Website and Administration Panel

- **Website**: Accessible at `https://<your_login>.42.fr`.
- **WordPress Admin Panel**: Go to `https://<your_login>.42.fr/wp-admin` and log in using the credentials specified in your `.env` file.

Once logged in, you can manage your site, add posts, add comments, delete posts, etc.

---

## Locate and Manage Credentials

All credentials (database, WordPress admin, etc.) are defined in the `.env` file at the root of the project. **Never share or commit this file.**

---

## Check Services Status

- **List running containers**:
  ```bash
  docker ps
  ```
- **List all containers (including stopped ones)**:
  ```bash
  docker ps -a
  ```
- **View logs for all services**:
  ```bash
  make logs
  ```
- **View logs for MariaDB**:
  ```bash
  make logs-mariadb
  ```
- **View logs for WordPress**:
  ```bash
  make logs-wordpress
  ```
- **View logs for Nginx**:
  ```bash
  make logs-nginx
  ```