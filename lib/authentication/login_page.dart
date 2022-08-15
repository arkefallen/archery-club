import 'package:archery_club/authentication/auth_services.dart';
import 'package:archery_club/authentication/signup_page.dart';
import 'package:archery_club/constant/brand_colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Image.asset("assets/img/logo.png"),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Welcome !",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                "Sign In with your account or register if you don't have it",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: BrandColor.hintColor),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  labelText: "Email",
                  hintText: "Input your email address",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  labelText: "Password",
                  hintText: "Input your password",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var signInResult = await AuthServices.signIn(
                      emailController.text, passwordController.text);

                  if ( signInResult == 'invalid-email' ) {
                    return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Login Failed'),
                          content:
                              const Text('The email that you input is not valid'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Back'))
                          ],
                        );
                      },
                    );
                  } else if ( signInResult == 'wrong-password') {
                    return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Invalid Password'),
                          content:
                              const Text('You entered a wrong password or invalid'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Back'))
                          ],
                        );
                      },
                    );
                  } else if ( signInResult == 'user-not-found' ) {
                    return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('User not Found'),
                          content:
                              const Text('There is no user found corresponding to the given email'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Back'))
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text("SIGN IN"),
                style: ElevatedButton.styleFrom(
                    primary: BrandColor.colorPrimary,
                    minimumSize: const Size.fromHeight(50)),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterAccount()));
                },
                child: const Text("REGISTER"),
                style: OutlinedButton.styleFrom(
                    primary: BrandColor.colorPrimary,
                    minimumSize: const Size.fromHeight(50)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
