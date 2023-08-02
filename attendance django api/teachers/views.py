from .models import *
from django.http import JsonResponse
import json


def teacher_login_api(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')

        try:
            # Query the Teachers model to check if the provided credentials exist
            teacher = Teachers.objects.get(prn=username, password=password)

            # If the teacher is found, return the teacher data as a response
            response_data = {
                'success': True,
                'message': 'Login successful',
                'teacher_id': teacher.teacher_id,
                'prn': teacher.prn,
                'first_name': teacher.first_name,
                'middle_name': teacher.middle_name,
                'last_name': teacher.last_name,
                'dob': teacher.dob.isoformat() if teacher.dob else None,
                'phone_number': teacher.phone_number,
                'email': teacher.email,
                'class_id': teacher.class_id,
                'post': teacher.post,
            }
            return JsonResponse(response_data)

        except Teachers.DoesNotExist:
            # If the teacher is not found, return an error response
            response_data = {'success': False, 'message': 'Invalid credentials'}
            return JsonResponse(response_data, status=401)

    response_data = {'success': False, 'message': 'Invalid request'}
    return JsonResponse(response_data, status=400)


def get_students_by_class_api(request):
    if request.method == 'POST':
        class_id = request.POST.get('class_id')
        try:
            # Query the Students model to get all students with the specified class_id
            students = Students.objects.filter(class_id=class_id).order_by('roll_no')

            # Prepare the list of student data
            student_data = []
            for student in students:
                student_data.append({
                    'student_id': student.student_id,
                    'prn': student.prn,
                    'first_name': student.first_name,
                    'middle_name': student.middle_name,
                    'last_name': student.last_name,
                    'dob': student.dob.isoformat() if student.dob else None,
                    'phone_number': student.phone_number,
                    'email': student.email,
                    'class_id': student.class_id,
                    'roll_no': student.roll_no,
                })

            # If students are found, return the student data as a response
            response_data = {
                'success': True,
                'message': 'Students found',
                'students': student_data,
            }
            return JsonResponse(response_data)

        except Students.DoesNotExist:
            # If no students are found for the given class_id, return an empty response
            response_data = {'success': True, 'message': 'No students found', 'students': []}
            return JsonResponse(response_data)

    response_data = {'success': False, 'message': 'Invalid request'}
    return JsonResponse(response_data, status=400)


def add_student_attendance(request):
    if request.method == 'POST':
        attendance_data = request.POST.get('attendance_data')
        class_id = request.POST.get('class_id')
        subject = request.POST.get('selected_subject')

        try:
            attendance_data = json.loads(attendance_data)
            print("Attendance_data: ", attendance_data)

            for entry in attendance_data:
                student_id = entry['student_id']
                date = entry['date']
                status = entry['status']
                subject = entry['subject']

                # Assuming the student_id exists in the Students model
                try:
                    student = Students.objects.get(pk=student_id)
                except Students.DoesNotExist:
                    # Handle the case where the student_id does not exist
                    # You may log or raise an error, or simply continue to the next entry
                    continue

                # Create an Attend object and save it to the database
                Attend.objects.create(student_id=student, date=date, status=status, subject=subject)

            response_data = {'message': 'Attendance added successfully'}
            return JsonResponse(response_data, status=201)

        except Exception as e:
            response_data = {'error': str(e)}
            return JsonResponse(response_data, status=400)

    response_data = {'message': 'Invalid request method'}
    return JsonResponse(response_data, status=405)