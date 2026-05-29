import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/about%20app/ui/about_app._screen.dart';
import 'package:programmin/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:programmin/features/auth/ui/login_screen.dart';
import 'package:programmin/features/edit/ui/edit_profile_screen.dart';
import 'package:programmin/features/profile/ui/widgets/custom_container_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: AppColors.primaryPurple,

                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,

                    child: user?.photoURL == null
                        ? Icon(IconlyLight.profile)
                        : null,
                  ),

                  SizedBox(width: 12.w),
                  Text(
                    "My Profile",
                    style: TextStyle(fontSize: 30.sp, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 12.h),

              CustomContainerList(
                icon: IconlyLight.profile,
                title: "Edit Profile",
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, animation, _) =>
                          const EditProfileScreen(),
                      transitionsBuilder: (_, animation, _, child) {
                        return SlideTransition(
                          position: Tween(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                isDestructive: false,
              ),

              CustomContainerList(
                icon: IconlyLight.info_circle,
                title: "About App",
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, animation, _) => const AboutAppScreen(),
                      transitionsBuilder: (_, animation, _, child) {
                        return SlideTransition(
                          position: Tween(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                isDestructive: false,
              ),

              const Spacer(),

              CustomContainerList(
                icon: IconlyLight.logout,
                title: "Logout",
                isDestructive: true,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.pushAndRemoveUntil(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => AuthCubit(),
                        child: const LoginScreen(),
                      ),
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
