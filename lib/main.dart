import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:documed/Login/SignIn.dart'; // Update with the correct path to your login page
import 'package:documed/HomePage/HomePage.dart';
import 'package:documed/download_option/dropdownpage.dart';
// Update with the correct path to your home page

void main() async {

  void addUserFiles() async {
    var box = await Hive.openBox('user_files');
    box.put('USER_ID/license_uemf.pdf', 'lib/User_data/QpVmuT2rwbYkkxwIUxcegcIUVp43/license_uemf.pdf');
    box.put('USER_ID/master_uemf.pdf', 'lib/User_data/QpVmuT2rwbYkkxwIUxcegcIUVp43/master_uemf.pdf');
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('login');
  await Hive.openBox('accounts');
  await Hive.openBox('user_files'); // Open the user_files box

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'documed',
      theme: ThemeData(
      ),
      home: const AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          return HomePage(); // User is signed in
        }
        return Login(); // User is not signed in
      },
    );
  }
}
