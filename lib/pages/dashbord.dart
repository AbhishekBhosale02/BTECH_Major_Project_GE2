import 'package:flutter/material.dart';
import 'package:sih_23_audiometer/utils/routes.dart';

void main() {
  runApp(Dashboard());
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool showAdditionalButtons = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Teacher Dashboard'),
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/admin.png'),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: FutureBuilder<String>(
                  future: fetchTeacherNameFromFirebase(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Loading...');
                    } else {
                      return Text(snapshot.data ?? 'Teacher Name');
                    }
                  },
                ),
                accountEmail: null,
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/admin.png'),
                ),
              ),
              ListTile(
                title: Text('Admin Home Page'),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, MyRoutes.adminhome);
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/student.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add functionality for elevator button 1
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Change the button color
                        onPrimary: Colors.white, // Change the text color
                      ),
                      child: Text('Student Details'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Toggle the visibility of additional buttons
                          showAdditionalButtons = !showAdditionalButtons;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange, // Change the button color
                        onPrimary: Colors.white, // Change the text color
                      ),
                      child: Text('Filter'),
                    ),
                    Visibility(
                      visible: showAdditionalButtons,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Add functionality for additional button 1
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 106, 184, 212), // Change the button color
                              onPrimary: Colors.white, // Change the text color
                            ),
                            child: Text('Test not Taken'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add functionality for additional button 2
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 200, 85, 79), // Change the button color
                              onPrimary: Colors.white, // Change the text color
                            ),
                            child: Text('Result of Hearing Loss'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add functionality for additional button 3
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 48, 150, 89), // Change the button color
                              onPrimary: Colors.white, // Change the text color
                            ),
                            child: Text('All Fine'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Add any other widgets or content you want below the image and buttons
          ],
        ),
      ),
    );
  }

  Future<String> fetchTeacherNameFromFirebase() async {
    await Future.delayed(Duration(seconds: 2));
    return 'John Doe';
  }
}
