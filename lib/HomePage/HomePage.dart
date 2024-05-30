import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:documed/HomePage/Screens/Screen1.dart';
import 'package:documed/HomePage/Screens/Screen2.dart';
import 'package:documed/HomePage/Screens/Screen3.dart'; // Ensure Screen3 is imported
import 'package:documed/Login/SignIn.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    Screen1(),
    Screen2(),
    Screen3(),
  ];

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()), // Ensure the correct widget is used for SignIn
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent, // Match the container's background color
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: FloatingActionButton(
              onPressed: _signOut,
              backgroundColor: Colors.white,
              child: Icon(Icons.exit_to_app,color: Colors.lightBlueAccent,),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 85,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
        decoration: BoxDecoration(
          color: Colors.white, // Set the navigation bar background to white
          borderRadius: BorderRadius.circular(30), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(1), // Soften the shadow
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted),
                label: 'Activities',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue[800], // Set selected item color to blue
            unselectedItemColor: Colors.blue[300], // Set unselected item color to a lighter blue
            onTap: _onItemTapped,
            backgroundColor: Colors.transparent, // Transparent background inside the clipped area
            elevation: 0, // No elevation for the inner navigation bar
          ),
        ),
      ),
    );
  }
}
