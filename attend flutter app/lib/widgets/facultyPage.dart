import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'FacultyPage/profile.dart';
import 'FacultyPage/takeattendance.dart';
import 'FacultyPage/settings.dart';

class FacultyPage extends StatefulWidget {
  final Map<String, dynamic> responseData;
  const FacultyPage({
    Key? key,
    required this.responseData,
  }) : super(key: key);

  @override
  _FacultyPageState createState() => _FacultyPageState();
}

class _FacultyPageState extends State<FacultyPage> {
  int _selectedIndex = 0;
  
  List<Widget> _pages = [];

  @override
  void initState() {
    _pages = [
      ProfilePage(responseData: widget.responseData),
      TakeAttendancePage(),
      SettingsPage(),
    ];
    super.initState();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: GNav(
            tabBackgroundColor: Colors.white,
            tabBorderRadius: 50,
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Profile',
              ),
              GButton(
                icon: Icons.calendar_month,
                text: 'Attendance',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: _onTabTapped,
          ),
        ),
      ),
    );
  }
}
