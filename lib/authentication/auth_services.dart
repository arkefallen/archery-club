import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // static Future<User?> signInAnonymous() async {
  //   // store the result of sign in anonymously process
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? firebaseUser = result.user;

  //     return firebaseUser;
  //   } on FirebaseAuthException catch (e) {
  //     i
  //   }
  // }

  static Future<User?> signUp(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      firebaseUser!.updateDisplayName(name);

      await firebaseUser.sendEmailVerification();

      AlertDialog(
        title: const Text('Email Verification'),
        content: Text("We have sent email verification to ${email}"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, 'Back'),
              child: const Text('Ok, I will verified my email'))
        ],
      );

      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Weak Password'),
                  content: const Text(
                      "The password provided is too weak. Try different password with minimum 6 characters"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Back'),
                      child: const Text('Back'),
                    )
                  ],
                ));
      } else if (e.code == 'email-already-in-use') {
        return showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Email Already In Use'),
                  content:
                      const Text("The account already exists for that email"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Back'),
                      child: const Text('Back'),
                    )
                  ],
                ));
      } else {
        return showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Failed Register'),
                  content: Text(e.message.toString()),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Back'),
                      child: const Text('Back'),
                    )
                  ],
                ));
      }
    }
  }

  static Future<Object?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return user;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<User?> get firebaseUserStream => _auth.authStateChanges();
}
