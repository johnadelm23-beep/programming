import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/admin/ui/admin_add_playlist_screen.dart';
import 'package:programmin/features/ai/ui/ai_chat.dart';
import 'package:programmin/features/courses/ui/courses_screen.dart';
import 'package:programmin/features/home/cubit/cubit/home_cubit.dart';
import 'package:programmin/features/home/ui/home_screen.dart';
import 'package:programmin/features/mainScreen/ui/custom_build_bottom_nav_bar.dart';
import 'package:programmin/features/profile/ui/profile_screen.dart';
class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});
  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}
class _MainShellScreenState extends State<MainShellScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final user = context.watch<HomeCubit>().userData;
    final List<Widget> screens = [
      const HomeScreen(),
      CoursesScreen(),
      const ProfileScreen(),
      const ChatScreen(),
      if (user?.isAdmin == true) AdminAddPlaylistScreen(),
    ];
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: IndexedStack(index: currentIndex, children: screens),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
        CustomBottomNavItem    (icon:  IconlyLight.home,activeIcon:  IconlyBold.home,label:  "Home",isActive: currentIndex== 0,onTap: ()=>setState(()=>currentIndex=0),),
            CustomBottomNavItem(icon:  IconlyLight.bookmark,activeIcon:  IconlyBold.bookmark,label:  "Courses",isActive: currentIndex== 1,onTap: ()=>setState(()=>currentIndex=1),),
            CustomBottomNavItem(icon:  IconlyLight.profile,activeIcon:   IconlyBold.profile,label:  "Profile",isActive: currentIndex== 2,onTap: ()=>setState(()=>currentIndex=2),),
            CustomBottomNavItem(icon:  IconlyLight.chat,activeIcon:  IconlyLight.chat,label:  "Chat", isActive: currentIndex== 3,onTap: ()=>setState(()=>currentIndex=3),),
            if (user?.isAdmin == true)
              CustomBottomNavItem(icon:  IconlyLight.setting,activeIcon:  IconlyBold.setting,label:  "Admin",isActive: currentIndex==  4,onTap: ()=>setState(()=>currentIndex=4),),
          ],
        ),
      ),
    );
  }
}
