# Generated by Django 4.2.3 on 2023-07-30 20:49

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Students',
            fields=[
                ('student_id', models.AutoField(primary_key=True, serialize=False)),
                ('prn', models.CharField(max_length=10, unique=True)),
                ('first_name', models.CharField(max_length=50)),
                ('middle_name', models.CharField(blank=True, max_length=50, null=True)),
                ('last_name', models.CharField(max_length=50)),
                ('dob', models.DateField(blank=True, null=True)),
                ('phone_number', models.CharField(blank=True, max_length=20, null=True)),
                ('email', models.EmailField(blank=True, max_length=100, null=True)),
                ('class_id', models.IntegerField()),
                ('roll_no', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Teachers',
            fields=[
                ('teacher_id', models.AutoField(primary_key=True, serialize=False)),
                ('prn', models.CharField(max_length=10, unique=True)),
                ('first_name', models.CharField(max_length=50)),
                ('middle_name', models.CharField(blank=True, max_length=50, null=True)),
                ('last_name', models.CharField(max_length=50)),
                ('dob', models.DateField(blank=True, null=True)),
                ('phone_number', models.CharField(blank=True, max_length=20, null=True)),
                ('email', models.EmailField(blank=True, max_length=100, null=True)),
                ('class_id', models.IntegerField(blank=True, null=True)),
                ('post', models.IntegerField()),
                ('password', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Classes',
            fields=[
                ('class_id', models.AutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=10, unique=True)),
                ('teacher_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='teachers.teachers')),
            ],
        ),
        migrations.CreateModel(
            name='Attend',
            fields=[
                ('attend_id', models.AutoField(primary_key=True, serialize=False)),
                ('date', models.DateField()),
                ('status', models.BooleanField()),
                ('subject', models.CharField(max_length=50)),
                ('student_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='teachers.students')),
            ],
        ),
    ]
