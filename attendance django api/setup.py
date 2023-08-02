from teachers.models import *
import random
import string
from datetime import date, timedelta
from django.contrib.auth.models import User
from django.contrib.auth.models import User


def create_superuser():
    # Replace these values with the desired username, email, and password
    username = "admin"
    email = "admin@example.com"
    password = "admin"

    # Check if a superuser with the given username already exists
    if User.objects.filter(username=username).exists():
        print("Superuser already exists.")
        return

    # Create a superuser
    superuser = User.objects.create_superuser(username=username, email=email, password=password)
    print("Superuser created successfully:", superuser)


def initiate():
    create_superuser()

    def random_string(length):
        letters = string.ascii_letters
        return ''.join(random.choice(letters) for i in range(length))

    class_data = []

    for i in range(1, 6):
        prn = f'T{str(i).zfill(5)}'
        first_name = random_string(5)
        last_name = random_string(7)
        dob = '1985-01-01'  # Replace this with the actual date of birth format
        phone_number = ''.join(random.choice(string.digits) for i in range(10))
        email = f'{first_name}.{last_name}@example.com'
        post = random.choice([1, 2, 3])
        hashed_password = 'hashed_password' + str(i)

        class_data.append({
            'prn': prn,
            'first_name': first_name,
            'last_name': last_name,
            'dob': dob,
            'phone_number': phone_number,
            'email': email,
            'post': post,
            'password': hashed_password,
        })

    # Create teacher instances
    for data in class_data:
        Teachers.objects.create(
            prn=data['prn'],
            first_name=data['first_name'],
            last_name=data['last_name'],
            dob=data['dob'],
            phone_number=data['phone_number'],
            email=data['email'],
            post=data['post'],
            password=data['password'],
        )

    print("Teachers Added")

    # Get all teacher instances from the Teachers table
    teachers = Teachers.objects.all()

    # Get two random teachers from the list
    random_teachers = random.sample(list(teachers), 2)

    # Create two class instances and associate them with the random teachers
    class_data = [
        {'name': 'A', 'teacher_id': random_teachers[0]},
        {'name': 'B', 'teacher_id': random_teachers[1]}
    ]

    for data in class_data:
        Classes.objects.create(
            name=data['name'],
            teacher_id=data['teacher_id'],
        )

    print("Classes Added")

    def random_string(length):
        letters = string.ascii_letters
        return ''.join(random.choice(letters) for i in range(length))

    def generate_prn(index):
        return f'S{str(index).zfill(5)}'

    class_data = []
    roll_no = 1
    for i in range(1, 101):
        prn = generate_prn(i)
        first_name = random_string(5)
        last_name = random_string(7)
        dob = '2000-01-01'  # Replace this with the actual date of birth format
        phone_number = ''.join(random.choice(string.digits) for i in range(10))
        email = f'{first_name}.{last_name}@example.com'
        class_id = 1

        if roll_no > 50:
            roll_no = 1
        if i > 50:
            class_id = 2

        class_data.append({
            'prn': prn,
            'first_name': first_name,
            'last_name': last_name,
            'dob': dob,
            'phone_number': phone_number,
            'email': email,
            'class_id': class_id,
            'roll_no': roll_no,
        })
        roll_no += 1

    # Create student instances
    for data in class_data:
        Students.objects.create(
            prn=data['prn'],
            first_name=data['first_name'],
            last_name=data['last_name'],
            dob=data['dob'],
            phone_number=data['phone_number'],
            email=data['email'],
            class_id=data['class_id'],
            roll_no=data['roll_no'],
        )

    print("Students Added")