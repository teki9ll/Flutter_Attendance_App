# Project Name

## Description

This project is a web and mobile application developed using Flutter, Django, and MySQL. It aims to provide a seamless and user-friendly experience for users by combining the power of Flutter for the mobile frontend, Django for the backend, and MySQL for database management.

## Prerequisites

Before running this project, make sure you have the following installed:

- Flutter: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Django: [Installation Guide](https://docs.djangoproject.com/en/stable/intro/install/)
- MySQL: [Installation Guide](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/)

## Getting Started

### A. MySQL

1. First, install MySQL. The default username and password are "root" & "root".
2. Create a database called "attendance".

### B. Django

1. Install requirements from req.txt by running: `pip install -r req.txt`.
2. Run migrations:
      python manage.py makemigrations teachers
      python manage.py migrate
3. Start the Django shell:
      python manage.py shell

4. Inside the shell, run the following commands to add dummy data to the database and create a superuser (username: admin, password: admin)
      import setup
      setup.create()
      exit()  # exit the shell

5. Finally, start the Django development server: python manage.py runserver 0.0.0.0:80
