import 'package:attendance/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the package to launch URLs

class SettingsPage extends StatelessWidget {
  // Function to open the GitHub URL in Chrome
  void _openGitHubPage() async {
  const url = 'https://github.com/teki9ll'; // Replace with your GitHub URL
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false, forceWebView: false);
  } else {
    print('Could not launch the URL. Fallback action or error message here.');
  }
}

  // Function to handle Logout button tap and show a confirmation dialog
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                _handleLogout(context);
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  // Function to handle Logout and navigate to Login page
  void _handleLogout(BuildContext context) {
    Navigator.of(context).pushNamed('/login'); // Replace '/login' with your login page route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text('Settings'),
      //  actions: [
      //    IconButton(
      //      icon: Icon(Icons.settings),
      //      onPressed: () {
      //        // Add any action on settings icon if needed
      //      },
      //    ),
      //  ],
      //),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.settings, size: 32),
                SizedBox(width: 8),
                Text(
                  'Settings:',
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

          ListTile(
            leading: Icon(Icons.info),
            title: Text('https://github.com/teki9ll'),
            onTap: () => _openGitHubPage(),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('https://www.linkedin.com/in/tejas-solanke/'),
            onTap: () => _openGitHubPage(),
          ),
          Divider(height: 1),
          Spacer(),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () => _showLogoutConfirmation(context),
          ),
        ],
      ),
    );
  }
}
