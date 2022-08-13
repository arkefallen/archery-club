import 'package:archery_club/authentication/auth_services.dart';
import 'package:archery_club/constant/brand_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: ClipOval(
                child: Image.asset('assets/img/user.png'),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              user.displayName!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
              style: OutlinedButton.styleFrom(
                  primary: BrandColor.colorPrimaryDark,
                  minimumSize: const Size.fromHeight(50)),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                    primary: Colors.redAccent,
                    minimumSize: const Size.fromHeight(50),
                    side: BorderSide(color: Colors.redAccent)
                ),
                icon: const Icon(Icons.logout_sharp),
                onPressed: () async {
                  await AuthServices.signOut();
                },
                label: const Text("Log Out"),
            )
          ],
        ),
      ),
    );
  }
}
