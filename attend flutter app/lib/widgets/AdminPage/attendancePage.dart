import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AttendancePage extends StatefulWidget {
  final int classId;
  final String? selectedSubject;
  final DateTime date;
  final List<dynamic> students;

  AttendancePage({
    required this.classId,
    required this.selectedSubject,
    required this.date,
    required this.students,
  });

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late List<bool> _isPresent;
  late int _present;
  late int _absent;

  @override
  void initState() {
    super.initState();
    _isPresent = List<bool>.generate(widget.students.length, (index) => true);
    _present = widget.students.length;
    _absent = 0;
  }

  Future<void> _submitAttendance() async {
    List<Map<String, dynamic>> attendanceData = [];

    for (int i = 0; i < widget.students.length; i++) {
      Map<String, dynamic> studentData = {
        'student_id': widget.students[i]['student_id'],
        'date': widget.date.toLocal().toString().split(' ')[0],
        'status': _isPresent[i],
        'subject': widget.selectedSubject,
      };
      attendanceData.add(studentData);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Attendance Submission'),
          content: Text('Are you sure you want to submit the attendance?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _sendAttendanceData(attendanceData);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  
  Future<void> _sendAttendanceData(
      List<Map<String, dynamic>> attendanceData) async {
    Uri url = Uri.parse('http://192.168.1.5/api/add_attendance/');
    http.Response response = await http.post(
      url,
      body: {
      'attendance_data': json.encode(attendanceData),
    },
    );

    if (response.statusCode == 201) {
      // Attendance submitted successfully
      print('Attendance submitted successfully');

      // Show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance submitted successfully.'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop();
      // Optionally, you can navigate back to the previous screen or perform any other actions.
      // For example, you can use:
      // Navigator.of(context).pop();
      // to navigate back after successful attendance submission.
    } else {
      // Failed to submit attendance
      print('Failed to submit attendance. Status code: ${response.statusCode}');

      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit attendance. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //appBar: AppBar(
      //  title: Text('Attendance Page'),
      //),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
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
            const SizedBox(height: 10),
            const ImageIcon(
              AssetImage('assets/images/teacher.png'),
              size: 150, // set the size of the icon
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_circle_left),
                    iconSize: 30,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 30, color: Colors.green),
                      const SizedBox(width: 5),
                      Text('Present: $_present'),
                      const SizedBox(width: 15),
                      const Icon(Icons.person, size: 30, color: Colors.red),
                      const SizedBox(width: 5),
                      Text('Absent: $_absent'),
                      const SizedBox(width: 15),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.students.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPresent[index] = !_isPresent[index];
                          if (_isPresent[index]) {
                            _present++;
                            _absent--;
                          } else {
                            _present--;
                            _absent++;
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: _isPresent[index]
                                ? Colors.green
                                : const Color.fromARGB(255, 247, 75, 75),
                            width: 2,
                          ),
                          color: _isPresent[index]
                              ? Colors.green
                              : Color.fromARGB(255, 247, 207, 207),
                        ),
                        margin: EdgeInsets.only(
                          right: index % 2 == 1 ? 6 : 0,
                          left: index % 2 == 0 ? 6 : 0,
                          top: 8,
                        ),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: _isPresent[index]
                                  ? Colors.white
                                  : const Color.fromARGB(255, 247, 75, 75),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Class : ${widget.classId == 1 ? 'A' : (widget.classId == 2 ? 'B' : 'Unknown')}          "),
              
                    Text(
                        "Subject : ${widget.selectedSubject ?? 'N/A'}") // Display 'N/A' if subject is null
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () => _submitAttendance(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
