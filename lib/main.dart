import 'package:flutter/material.dart';
import 'package:login_demo/firebase_initilization.dart';
import 'package:login_demo/logic.dart';
import 'package:login_demo/logicv2.dart';
import 'package:login_demo/screens/edit_notes.dart';
import 'package:login_demo/screens/login_screen.dart';
import 'package:login_demo/screens/notes.dart';
import 'package:login_demo/ui_screens/ui_notes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers:
      [
      ChangeNotifierProvider(create: (_) => LogicV2()),
    ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseInitilization(),
    );
  }
}

