from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.teacher_login_api, name='teacher_login_api'),
    path('students/', views.get_students_by_class_api, name='get_students_by_class_api'),
    path('add_attendance/', views.add_student_attendance, name='add_attendance'),
]
