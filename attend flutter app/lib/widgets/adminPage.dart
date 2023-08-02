import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Welcome Master'),
      //   actions: [
      //     PopupMenuButton(
      //       itemBuilder: (BuildContext context) => <PopupMenuEntry>[
      //         const PopupMenuItem(
      //           value: 'log_out',
      //           child: Text('Log Out'),
      //         ),
      //       ],
      //       onSelected: (value) {
      //         if (value == 'log_out') {
      //           Navigator.of(context).pop();
      //         }
      //       },
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue[400]!,
                  Colors.lightBlue[200]!,
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              Icon(Icons.admin_panel_settings_rounded,
                  size: 100, color: Colors.white),
              SizedBox(height: 10),
              Text(
                'Admin Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
