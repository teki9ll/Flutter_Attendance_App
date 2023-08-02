import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../AdminPage/attendancePage.dart';

class TakeAttendancePage extends StatefulWidget {
  @override
  _TakeAttendancePageState createState() => _TakeAttendancePageState();
}

class _TakeAttendancePageState extends State<TakeAttendancePage> {
  String? _selectedClass;
  String? _selectedSubject;
  DateTime _selectedDate = DateTime.now();
  bool _canSubmit = false;

  final List<String> classOptions = ['Class A', 'Class B'];
  final List<String> subjectOptions = ['English', 'Maths', 'Science'];

  Future<void> _handleTakeAttendance(BuildContext context) async {
    if (_selectedClass == null || _selectedSubject == null) {
      return; // Do not proceed if class or subject is not selected
    }

    int classId = _selectedClass == 'Class A' ? 1 : 2;

    Map<String, String> data = {'class_id': classId.toString()};
    Uri url = Uri.parse('http://192.168.1.5/api/students/');
    http.Response response = await http.post(
      url,
      body: data,
    );

    if (response.statusCode == 200) {
    // Parse the JSON response data here
    Map<String, dynamic> responseData = json.decode(response.body);

    // Check if the request was successful on the server side
    if (responseData['success']) {
      // Get the list of students from the response
      List<dynamic> students = responseData['students'];
      print(classId);
      print(_selectedSubject);
      print(_selectedDate);
      print(students);

      // You can now use the students list in the AttendancePage or store it in the state
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AttendancePage(
            classId: classId,
            selectedSubject: _selectedSubject,
            date: _selectedDate,
            students: students,
          ),
        ),
      );
    } else {
      // Handle error response from the server (e.g., invalid class_id)
      print(responseData['message']);
    }
  } else {
    // Handle other status codes (e.g., 400, 404, etc.)
    print('Request failed with status: ${response.statusCode}');
  }
  }

  void _updateCanSubmit() {
    setState(() {
      _canSubmit = _selectedClass != null &&
          _selectedSubject != null;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _updateCanSubmit(); // Update the button state after the date is selected
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text('Take Attendance'),
      //),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.0),
              child: Row(
                children: [
                  Icon(Icons.calendar_month, size: 32),
                  SizedBox(width: 8),
                  Text(
                    'Attendance:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Divider(height: 1),
            const SizedBox(height: 20),
            Text(
              'Select Class:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16.0,
              children: classOptions.map((String option) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: _selectedClass,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedClass = value;
                          _updateCanSubmit(); // Update the button state after the class is selected
                        });
                      },
                    ),
                    Text(option),
                  ],
                );
              }).toList(),
            ),
            Divider(height: 30, thickness: 2, color: Colors.grey[300]),
            Text(
              'Select Subject:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16.0,
              children: subjectOptions.map((String option) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: _selectedSubject,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedSubject = value;
                          _updateCanSubmit(); // Update the button state after the subject is selected
                        });
                      },
                    ),
                    Text(option),
                  ],
                );
              }).toList(),
            ),
            Divider(height: 30, thickness: 2, color: Colors.grey[300]),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Select Date',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  '${_selectedDate.toLocal()}'.split(' ')[0],
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _canSubmit ? Color.fromARGB(255, 0, 0, 0) : Colors.grey,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _canSubmit ? () => _handleTakeAttendance(context) : null,
              child: Text('Take Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
