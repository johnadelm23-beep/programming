import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Lottie.asset(""),
            SizedBox(height: 10.h),
            Text("Coding is a tool to convert programmer to caffine!"),
          ],
        ),
      ),
    );
  }
}
