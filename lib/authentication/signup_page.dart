import 'package:archery_club/authentication/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant/brand_colors.dart';

class RegisterAccount extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference members = firestore.collection('members');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign Up",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "Create and register your account",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: BrandColor.hintColor),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                labelText: "Full Name",
                hintText: "Input your name",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                labelText: "Email",
                hintText: "example : john.doe@gmail.com",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                labelText: "Password",
                hintText: "Minimum 6 characters",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  members.add({
                    'name': nameController.text,
                    'email': emailController.text,
                    'password': passwordController.text,
                    'phone': '',
                    'address': '',
                    'gender': '',
                    'birth_date': '',
                    'join_date': '',
                    'job': '',
                    'role': '',
                    'nik': '',
                    'profile_photo': 'assets/img/user.png'
                  });

                  await AuthServices.signUp(
                      emailController.text, passwordController.text, nameController.text);

                  Navigator.pop(context);
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Failed Register'),
                            content: Text(e.toString()),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Back'),
                                child: const Text('Back'),
                              )
                            ],
                          ));
                }
              },
              child: const Text("REGISTER ACCOUNT"),
              style: ElevatedButton.styleFrom(
                  primary: BrandColor.colorPrimary,
                  minimumSize: const Size.fromHeight(50)),
            ),
          ],
        )),
      ),
    );
  }
}
