import 'package:flutter/material.dart';

class StudentPage extends StatefulWidget {
  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
        backgroundColor: Colors.blue,
      ),
      drawer: _buildSidebar(context),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 252, 251, 252),
              Color.fromARGB(255, 143, 145, 245)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStudentDetailsCard(),
              SizedBox(height: 20),
              _buildAttendanceCard(),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildStudentDetailsCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 247, 134, 247),
              Color.fromARGB(255, 108, 183, 245)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Student Details',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person,
                  size: 120,
                  color: Colors.white,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'John Doe',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'TY CSE B (36114)',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'PRN: A123456789',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card _buildAttendanceCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 245, 165, 225),
              Color.fromARGB(255, 129, 206, 250)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Attendance Percentage',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                '75%',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildSidebar(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              'Sidenav',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
// navigate to settings page
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
// log out user
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
