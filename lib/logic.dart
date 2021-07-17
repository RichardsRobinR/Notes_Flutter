import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_demo/Users.dart';
import 'package:firebase_core/firebase_core.dart';

class Logic extends ChangeNotifier {

  String userUid = 'astSmGLvIScVpqCmjlcPhJJVTz02';




  void getFireBaseAuth() {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((event) {
      if (event == null) {
        print('user is currently signed out');
      } else {
        print('user is signed in');
      }
    });
//notifyListeners();
  }

  void create() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: 'test@test.com', password: 'testasasa');
  }

  void signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: 'test@test.com', password: 'testasasa');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void User() {

    // {required String fullname,required String company,required int age}




    final String fullName = 'redwolf';
    final String company = 'rdx';
    final int age = 24;

    final String title = 'welcome';
    final String description = 'hellllllllloooooooooooo world';

    // Map<String, dynamic> data = {
    //   'full_name': fullName, // John Doe
    //   'company': company, // Stokes and Sons
    //   'age': age
    // };

    Map<String, dynamic> data = {
      "title": title,
      "description": description,
    };


    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(userUid).collection('notes').doc()
        .set(data)
        .then((value) => print('user added'))
        .catchError((error) => print('failed to add user : $error'));

    // users
    //     .add({
    //       'full_name': fullName, // John Doe
    //       'company': company, // Stokes and Sons
    //       'age': age // 42
    //     })
    //     .then((value) => print('user added'))
    //     .catchError((error) => print('failed to add user : $error'));
  }

  void readData()  async {

    int? data;
    CollectionReference users = FirebaseFirestore.instance.collection('users').doc(userUid).collection('notes');

    // final usersRef = FirebaseFirestore.instance.collection('users').withConverter<Users>(
    //   fromFirestore: (snapshot, _) => Users.fromJson(snapshot.data()!),
    //   toFirestore: (usersList, _) =>usersList.toJson(),
    // );
    // //
    // //
    // List<QueryDocumentSnapshot<Users>> movies = await usersRef
    //     .where('full_name', isEqualTo: 'king')
    //     .get()
    //     .then((snapshot) => snapshot.docs);



    // users.get().then((QuerySnapshot snapshot) => {
    //   snapshot.docs.map((e) => print(e.id)).toList(),
    // });

    users.get().then((QuerySnapshot snapshot) => {
      print( snapshot.docs[0].data()),
      print( snapshot.docs.length),

    });








  }



  void deleteData() {

  }

}
