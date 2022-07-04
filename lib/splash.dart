import 'package:flutter/material.dart';
import 'main.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      // Push replacement

      /*  
          Untuk bisa berpindah dari halaman saat ini ke halaman lain
          lalu tidak bisa lagi kembali ke halaman awal 
      */

      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'ArcheryClub')
        )  
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.blue,
          ),
          Container(
            child: Text(
              'This is splash screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
