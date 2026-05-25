import 'package:flutter/material.dart';
import 'package:programmin/features/auth/ui/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'appFont'),
        home: LoginScreen(),
      ),
    );
  }
}
