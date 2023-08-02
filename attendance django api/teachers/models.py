from django.db import models


class Teachers(models.Model):
    teacher_id = models.AutoField(primary_key=True)
    prn = models.CharField(max_length=10, unique=True)
    first_name = models.CharField(max_length=50)
    middle_name = models.CharField(max_length=50, blank=True, null=True)
    last_name = models.CharField(max_length=50)
    dob = models.DateField(blank=True, null=True)
    phone_number = models.CharField(max_length=20, blank=True, null=True)
    email = models.EmailField(max_length=100, blank=True, null=True)
    class_id = models.IntegerField(blank=True, null=True)
    post = models.IntegerField()
    password = models.CharField(max_length=100)

    def __str__(self):
        return self.prn


class Classes(models.Model):
    class_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=10, unique=True)
    teacher_id = models.ForeignKey(Teachers, on_delete=models.CASCADE)

    def __str__(self):
        return self.name


class Students(models.Model):
    student_id = models.AutoField(primary_key=True)
    prn = models.CharField(max_length=10, unique=True)
    first_name = models.CharField(max_length=50)
    middle_name = models.CharField(max_length=50, blank=True, null=True)
    last_name = models.CharField(max_length=50)
    dob = models.DateField(blank=True, null=True)
    phone_number = models.CharField(max_length=20, blank=True, null=True)
    email = models.EmailField(max_length=100, blank=True, null=True)
    class_id = models.IntegerField()
    roll_no = models.IntegerField()

    def __str__(self):
        return self.prn


class Attend(models.Model):
    attend_id = models.AutoField(primary_key=True)
    student_id = models.ForeignKey(Students, on_delete=models.CASCADE)
    date = models.DateField()
    status = models.BooleanField()
    subject = models.CharField(max_length=50)

    def __str__(self):
        return str(self.attend_id)


class HTTPResponse(models.Model):
    response_content = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"HTTPResponse object (ID: {self.pk}, Timestamp: {self.timestamp})"
