import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/admin/ui/admin_add_playlist_screen.dart';
import 'package:programmin/features/ai/ui/ai_chat.dart';
import 'package:programmin/features/auth/data/models/user_model.dart';
import 'package:programmin/features/courses/ui/course.dart';
import 'package:programmin/features/courses/ui/courses_screen.dart';
import 'package:programmin/features/home/cubit/cubit/home_cubit.dart';
import 'package:programmin/features/home/ui/home_screen.dart';
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
            _buildItem(IconlyLight.home, IconlyBold.home, "Home", 0),
            _buildItem(IconlyLight.bookmark, IconlyBold.bookmark, "Courses", 1),
            _buildItem(IconlyLight.profile, IconlyBold.profile, "Profile", 2),
            _buildItem(IconlyLight.chat, IconlyLight.chat, "Chat", 3),

            if (user?.isAdmin == true)
              _buildItem(IconlyLight.setting, IconlyBold.setting, "Admin", 4),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
  ) {
    final isActive = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primaryPurple.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                color: isActive ? AppColors.primaryPurple : Colors.grey,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? AppColors.primaryPurple : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
