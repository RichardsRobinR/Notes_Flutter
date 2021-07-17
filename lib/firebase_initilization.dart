import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_demo/screens/login_screen.dart';
import 'package:login_demo/screens/notes.dart';

class FirebaseInitilization extends StatefulWidget {
  const FirebaseInitilization({Key? key}) : super(key: key);

  @override
  _FirebaseInitilizationState createState() => _FirebaseInitilizationState();
}

class _FirebaseInitilizationState extends State<FirebaseInitilization> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('error');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return CheckAuthenticate();
        }
        return Scaffold();
      },
    );
  }
}

class CheckAuthenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      return Notes();
    }
    return LoginScreen();
  }
}
