import 'package:archery_club/auth_services.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 80),
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
              Text(
                "Welcome to Archery Club !",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                "Sign In with your account or register if you don't have it",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: BrandColor.hintColor),
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
                  await AuthServices.signIn(
                      emailController.text, passwordController.text);
                },
                child: Text("SIGN IN"),
                style: ElevatedButton.styleFrom(
                    primary: BrandColor.colorPrimary,
                    minimumSize: Size.fromHeight(50)),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () async {
                  await AuthServices.signUp(
                      emailController.text, passwordController.text);
                },
                child: Text("REGISTER"),
                style: OutlinedButton.styleFrom(
                    primary: BrandColor.colorPrimary,
                    minimumSize: Size.fromHeight(50)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
