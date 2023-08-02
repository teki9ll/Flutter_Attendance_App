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
   
-      python manage.py makemigrations teachers
   
-      python manage.py migrate
   
4. Start the Django shell:
   
-      python manage.py shell

6. Inside the shell, run the following commands to add dummy data to the database and create a superuser (username: admin, password: admin)
   
-      import setup
   
-      setup.create()
   
-      exit()  # exit the shell

8. Finally, start the Django development server: python manage.py runserver 0.0.0.0:80

### C. Flutter 


Make sure to replace the http API request URL with your Django server's IP address:

1. Find and change the IP address to your Django server's IP.
   
-      main.dart           - line 39: final String apiUrl = "http://192.168.1.5/api/login/";
   
-      takeattendance.dart - line 28: Uri url = Uri.parse('http://192.168.1.5/api/students/');
   
-      attendancePage.dart - line 78: Uri url = Uri.parse('http://192.168.1.5/api/add_attendance/');
   
3. Use your phone as a virtual device and run the app on it.

## Contributing

Contributions to this project are welcome! If you find any issues or have ideas for improvements, please feel free to open an issue or submit a pull request. We appreciate any help in making this project better.

When contributing, please ensure the following:

- Describe your changes in detail, including the problem and solution.
- Provide clear and concise commit messages.
- Make sure your code follows the project's coding style and guidelines.

Thank you for contributing to this project!

## License

This project is licensed under the [MIT License](LICENSE). You can find the detailed terms in the [LICENSE](LICENSE) file.

## Thank You

Thank you for using this application and being a part of this community. Your support and feedback are invaluable to us. If you have any questions or need further assistance, please don't hesitate to reach out. We hope this project proves useful to you and others!

Happy coding!

