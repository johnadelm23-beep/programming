import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmin/features/auth/cubit/cubit/auth_cubit.dart';
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
        home: BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(),
        ),
      ),
    );
  }
}
