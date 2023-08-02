import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> responseData;

  ProfilePage({required this.responseData});

  @override
  Widget build(BuildContext context) {
    String teacherName = responseData['first_name'] + " " + responseData['last_name'];
    String phoneNumber = responseData['phone_number'];
    String email = responseData['email'];
    String dateOfBirth = responseData['dob'];

    return Scaffold(
      //appBar: AppBar(
      //  title: Text('Profile Page'),
      //),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
            const Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: Row(
              children: [
                Icon(Icons.home, size: 32),
                SizedBox(width: 8),
                Text(
                  'Profile:',
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
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
              ),
              SizedBox(height: 20),
              Text(
                teacherName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone'),
                  subtitle: Text(phoneNumber),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                  subtitle: Text(email),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.date_range),
                  title: Text('Date of Birth'),
                  subtitle: Text(dateOfBirth),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
