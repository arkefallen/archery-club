import 'package:archery_club/authentication/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hi, ${user} !"),
              ElevatedButton(
                  onPressed: () async {
                    await AuthServices.signOut();
                  },
                  child: Text("Log Out"))
            ],
          ),
        ),
      ),
    );
  }
}
