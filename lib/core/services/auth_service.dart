import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // instance of auth and FirebaseStroe
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore store = FirebaseFirestore.instance;
  //instace of google
  static GoogleSignIn google = GoogleSignIn();

  //current user

  User? getCurrentUser() {
     return auth.currentUser;
  }

  //sign up
  static Future<User?> registerUser(BuildContext context, String fullName,
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        await userCredential.user?.updateDisplayName(fullName);
      }
      store.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential.user;
    } catch (e) {
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Something is wrong")));
      });
    }
    return null;
  }

  //sign in
  static Future<User?> loginUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      //save info
      store.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential.user;
    } catch (e) {
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Something is wrong")));
      });
    }
    return null;
  }

  //sign in with google
  static Future<User?> loginWithGoogle() async {
    final GoogleSignInAccount? gUser = await google.signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }

  //delete
  static Future<void> deleteAccount() async {
    await auth.currentUser?.delete();
  }

  //log out
  static Future<void> logOut() async {
    await google.signOut();
    await auth.signOut();
  }
}
