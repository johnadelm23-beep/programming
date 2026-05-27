import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:programmin/features/auth/ui/login_screen.dart';
import 'package:programmin/features/home/cubit/cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeCubit>().getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is GetUserDataLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryBlue,
                  ),
                );
              }
              final user = context.watch<HomeCubit>().userData;
              if (user == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryPurple,
                  ),
                );
              }
              return Column(
                mainAxisAlignment: .start,
                children: [
                  Text(
                    "Hello ${user.name ?? ""} 😎",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  BlocProvider(
                                    create: (context) => AuthCubit(),
                                    child: const LoginScreen(),
                                  ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.ease;

                                final tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                        ),
                      );
                    },
                    icon: Icon(Icons.logout, color: Colors.white),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
