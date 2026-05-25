import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:programmin/features/auth/ui/register_screen.dart';

class CustomTextRich extends StatelessWidget {
  const CustomTextRich({
    super.key,
    required this.textOne,
    required this.textTwo,
  });
  final String textOne;
  final String textTwo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textOne,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BlocProvider(
                      create: (context) => AuthCubit(),
                      child: const RegisterScreen(),
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
          child: Text(
            textTwo,
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.primaryPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
