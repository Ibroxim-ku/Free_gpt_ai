import 'package:chat_app/auth_gate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 900), () {
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoDialogRoute(
            builder: (context) => const AuthGate(), context: context),
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFFFFFF),
        child: Center(
          child: Image.asset(
            "assets/images/welcome_splash.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
