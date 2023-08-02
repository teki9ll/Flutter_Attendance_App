import 'package:flutter/material.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  _MasterPageState createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  final TextEditingController _prnController = TextEditingController();

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
            children: [
              const Icon(Icons.admin_panel_settings_rounded,
                  size: 100, color: Colors.white),
              const SizedBox(height: 10),
              const Text(
                'Master Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _prnController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Student College Prn',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // Perform validation and navigate to details page
                    String prn = _prnController.text.trim();
                    if (prn.isNotEmpty) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(prn: prn),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Sumbit'),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 38, 93, 138),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Log Out'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String prn;

  const DetailsPage({Key? key, required this.prn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
      ),
      body: Center(
        child: Text('PRN: $prn'),
      ),
    );
  }
}
