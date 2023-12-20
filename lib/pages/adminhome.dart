import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:sih_23_audiometer/utils/routes.dart';
import 'package:sih_23_audiometer/widgets/themes.dart';

// ignore: camel_case_types, must_be_immutable
class adminhome extends StatelessWidget {
  String username; 
  adminhome({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(username),
    );
  }
}

class HomePage extends StatefulWidget {
  final String username;

  // Updated constructor to take username
  const HomePage(this.username,{super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
   String adminName = "John Doe";
   String classCode = "CS101";
  late Future<String> schoolName;
  final String adminImagePath = "assets/images/admin.png";
  final String outsideImagePath = "assets/images/admin.png";
  final DatabaseReference adminRef = FirebaseDatabase.instance.ref('admin');

  // @override
  // void initState() {
  //   // Calibration
  //   schoolName = fetchSchool();
  //   super.initState();
  // }

//   Future<String> fetchSchool() async {
//   try {
//     DatabaseReference userRef = FirebaseDatabase.instance.ref().child('admin').child(widget.username);
//     DataSnapshot dataSnapshot = await userRef.once();
    
//     // Assuming 'School' is the key where the school name is stored
//     String schoolName = dataSnapshot.child('School').value.toString();
    
//     return schoolName;
//   } catch (error) {
//     // Handle errors here, e.g., log the error or return a default value
//     // ignore: avoid_print
//     print('Error fetching school name: $error');
//     return 'Unknown School';
//   }
// }


  // ignore: non_constant_identifier_names
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home Page'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(adminName),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(adminImagePath),
              ),
            ),
            ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, MyRoutes.Dashboard);
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: MyTheme.buttonColor,
  ),
  child: const Text('Database'),
),

          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          FirebaseAnimatedList(
          query: adminRef, 
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
            // print('INSIDE FIREBASE');
            if(snapshot.child('class_code').value.toString() == widget.username) {

              setState(() {
                classCode = snapshot.child('class_code').value.toString();
                adminName = snapshot.child('Name').value.toString();
                schoolName = snapshot.child('School').value.toString() as Future<String>;
              });
            }
            return const SizedBox(height: 1);
          },
        ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                outsideImagePath,
                height: 150.0,
                width: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Admin Name: $adminName',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Class Code: $classCode',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            // Display the fetched school name
            Text(
              'School Name: $schoolName',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.leftear);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Customize button color
              ),
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}