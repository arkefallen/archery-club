import 'package:flutter/material.dart';
import 'home.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _navigateToHome(context);

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
        ],
      ),
    ));
  }

  _navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1500), () {
      // Push replacement
      /*  
          Untuk bisa berpindah dari halaman saat ini ke halaman lain
          lalu tidak bisa lagi kembali ke halaman awal 
      */

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const Home()));
    });
  }
}
