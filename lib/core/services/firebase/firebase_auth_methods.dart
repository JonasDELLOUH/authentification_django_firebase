import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utility/showSnackbar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  //Database
  static final firestoreInstance = FirebaseFirestore.instance;
  final fire_user = firestoreInstance.collection("Member");

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  // OTHER WAYS (depends on use case):
  // Stream get authState => FirebaseAuth.instance.userChanges();
  // Stream get authState => FirebaseAuth.instance.idTokenChanges();
  // KNOW MORE ABOUT THEM HERE: https://firebase.flutter.dev/docs/auth/start#auth-state

// EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
    Map<String, dynamic>memberMap = {
      "fullName": fullName,
      "mail": user.email,
      "imageUrl": "",
      "phone": phone,
      "uid": user.uid,
    };
    //AddUser;
    addUserToFirebase(memberMap);
  }
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(
          context, e.message!); // Displaying the usual firebase error message
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!user.emailVerified) {
        await sendEmailVerification(context);
        // restrict access to certain things using provider
        // transition to another page instead of home screen
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // GOOGLE SIGN IN
  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.additionalUserInfo;
    if(user!.isNewUser){
      Map<String, dynamic>memberMap = {
        "fullName": user?.username,
        "mail": _auth.currentUser?.email,
        "imageUrl": "",
        "phone": _auth.currentUser?.phoneNumber,
        "uid": _auth.currentUser?.uid,
      };
      //AddUser;
      addUserToFirebase(memberMap);
    }

    // Once signed in, return the UserCredential
    return userCredential;
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }


  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    }
  }

  addUserToFirebase(Map<String, dynamic> map) {
    fire_user.doc(map["uid"]).set(map);
  }

  void resetPassword({required String email, required BuildContext context}) async {
    await _auth
        .sendPasswordResetEmail(email: email);
  }





// //Auth
// final authInstance = FirebaseAuth.instance;
// //Connexion
// Future<User?> signIn(String mail, String pwd) async {
//   final userCredential = await authInstance.signInWithEmailAndPassword(
//       email: mail,
//       password: pwd
//   );
//   final User? user = userCredential.user;
//   return user;
// }
//
// //Création user
// Future<User?> createUser(String mail, String pwd, String fullName, String phone) async {
//   final userCredential = await authInstance.createUserWithEmailAndPassword(
//       email: mail,
//       password: pwd
//   );
//   final User? user = userCredential.user;
//   if (user != null) {
//     Map<String, dynamic>memberMap = {
//       "fullName": fullName,
//       "mail": user.email,
//       "imageUrl": "",
//       "phone": phone,
//       "uid": user.uid,
//     };
//     //AddUser;
//     addUserToFirebase(memberMap);
//   }
//
//   return user;
//
// }
//
// logOut() {
//   authInstance.signOut();
// }
//
}
