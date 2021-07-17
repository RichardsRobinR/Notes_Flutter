import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogicV2 extends ChangeNotifier {
  late String userUid;
  bool isTrue = false;

  Future<void> signIn({required String email, required String password}) async {
    // FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isTrue = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        isTrue = false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        isTrue = false;
      }
    }
  }

    // native google sign in
  Future<UserCredential> signInWithGoogle() async {



    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return   await FirebaseAuth.instance.signInWithCredential(credential);


  }

  String getGoogleProfilePic() {
    FirebaseAuth auth = FirebaseAuth.instance;

String pic;
      // userUid = auth.currentUser!.uid;

      // Map profileDetails = await {
      //   'profileName' : auth.currentUser!.displayName,
      //   'profilepic' : auth.currentUser!.photoURL,
      // };

    if (auth.currentUser != null) {
      return pic = auth.currentUser!.photoURL!;
      print(userUid);
    } else {
      return pic = null.toString();
    }

      //return auth.currentUser!.photoURL;

      //print(profileDetails['profileName']);

  }



  Future<void> websignInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({
      'login_hint': 'user@example.com'
    });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithRedirect(googleProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // void checkUserLoggedIn() {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //
  //   auth.authStateChanges().listen((event) {
  //     if (event == null) {
  //       print('user is currently signed out');
  //     } else {
  //       print('user is signed in');
  //     }
  //   });
  // }

  String checkCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      return userUid = auth.currentUser!.uid;
      print(userUid);
    } else {
      return userUid = null.toString();
    }
  }

  Stream<QuerySnapshot> readDataStream({required String userUid}) {
     var usersStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('notes').orderBy('createdOn',descending: true);

    return usersStream.snapshots();
  }

  Future<void> createNote(
      {required String title, required String description}) async {
    // {required String fullname,required String company,required int age}

    Map<String, dynamic> data = {
      "title": title,
      "description": description,
      'createdOn':FieldValue.serverTimestamp(),
    };

    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('notes');

    await users
        .doc()
        .set(data)
        .then((value) => print('user added'))
        .catchError((error) => print('failed to add user : $error'));
  }

  Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }

  Future<void> updateItem({
    required String title,
    required String description,
    required String docId,
  }) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .doc(docId);

    Map<String, dynamic> data = {
      "title": title,
      "description": description,
      'createdOn':FieldValue.serverTimestamp(),
    };

    await documentReference
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }




}


enum Execution {
create, update
}

