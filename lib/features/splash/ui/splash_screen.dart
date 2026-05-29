import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/auth/ui/login_screen.dart';
import 'package:programmin/features/home/ui/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,

        child: Center(
          child: Lottie.asset(
            'assets/splash/Scene.json',

            width: MediaQuery.of(context).size.width,

            height: MediaQuery.of(context).size.height,

            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
