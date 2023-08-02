import 'dart:convert';
import 'package:flutter/material.dart';
import 'widgets/masterPage.dart';
import 'widgets/adminPage.dart';
import 'widgets/facultyPage.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Attendance App",
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(username, password) async {

    final String apiUrl = "http://192.168.1.5/api/login/";
  
    final Map<String, String> data = {
      'username': username,
      'password': password,
    };

    try {
      var response = await http.post(Uri.parse(apiUrl), body: data);
      if (response.statusCode == 200) {
        // Successful login
        print("Login successful!");
        print(response.body);
      
        // Navigate to FacultyPage
        // ignore: use_build_context_synchronously
        errorCaught(0, "");
                      print("Welcome Faculty");
                      _usernameController.clear();
                      _passwordController.clear();
                      Map<String, dynamic> responseData = json.decode(response.body);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FacultyPage(responseData: responseData),
                        ),
                      );

      } else {
        // Login failed
        print("Login failed: ${response.statusCode}");
        print(response.body);  
      }
    } catch (e) {
      print("Error during login: $e");
      if (username.isEmpty || password.isEmpty) {
                        errorCaught(1, "All fields are required");
                      } else {
                        _usernameController.clear();
                        _passwordController.clear();
                        errorCaught(1,
                            "Sorry, your credentials were incorrect. Please double-check.");
                      }
    }
  }

  int errorFlag = 0;
  String message = "";

  void errorCaught(int status, String text) {
    setState(() {
      errorFlag = status;
      message = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Colors.cyan,
                  ]),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.account_circle, size: 100, color: Colors.white),
              const SizedBox(height: 10),
              const Text(
                'Attendance',
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
                  controller: _usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Username',
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
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Password',
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
                    final String username = _usernameController.text.trim();
                    final String password = _passwordController.text.trim();

                    if ((username == "admin" && password == "admin")) {
                      errorCaught(0, "");
                      print("Welcome Admin");
                      _usernameController.clear();
                      _passwordController.clear();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AdminPage(),
                        ),
                      );
                    } else if ((username == "master" && password == "master")) {
                      errorCaught(0, "");
                      print("Welcome Master");
                      _usernameController.clear();
                      _passwordController.clear();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MasterPage(),
                        ),
                      );
                    } else if ((username[0] == "T")) {
                      _login(username, password);
                    } else {
                      print("Incorrect Credentials - flag = $errorFlag");

                      if (username.isEmpty || password.isEmpty) {
                        errorCaught(1, "All fields are required");
                      } else {
                        _usernameController.clear();
                        _passwordController.clear();
                        errorCaught(1,
                            "Sorry, your credentials were incorrect. Please double-check.");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Log In'),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: InkWell(
                  onTap: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              errorFlag == 1
                  ? Center(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : const Text(""),
            ],
          ),
        ],
      ),
    );
  }
}
