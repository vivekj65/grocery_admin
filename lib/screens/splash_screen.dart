import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:grocery_admin/api/apis.dart';
import 'package:grocery_admin/main.dart';
import 'package:grocery_admin/screens/homescreen.dart';
import 'package:grocery_admin/screens/login_screen.dart';
import 'package:grocery_admin/themes/theme_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (APIs.auth.currentUser != null) {
        log('User: ${FirebaseAuth.instance.currentUser!.uid}');

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: HashColorCodes.green,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('images/logo.png'),
                height: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Admin App",
                style: TextStyle(
                    fontFamily: 'Sarala',
                    color: HashColorCodes.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
