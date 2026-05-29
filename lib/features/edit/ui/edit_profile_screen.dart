import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/home/cubit/cubit/home_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController.text = user?.displayName ?? "";
  }

  Future<void> updateProfile() async {
    setState(() => isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;

      final newName = nameController.text.trim();

      await user?.updateDisplayName(newName);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .update({"name": newName});

      await user.reload();

      if (mounted) {
        context.read<HomeCubit>().getUserData();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile Updated Successfully"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final u = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(IconlyLight.arrow_left_2, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            // PROFILE IMAGE
            CircleAvatar(
              radius: 45.r,
              backgroundImage: u?.photoURL != null
                  ? NetworkImage(u!.photoURL!)
                  : null,
              backgroundColor: AppColors.primaryPurple,
              child: u?.photoURL == null
                  ? Text(
                      (u?.email ?? "U")[0].toUpperCase(),
                      style: TextStyle(fontSize: 24.sp, color: Colors.white),
                    )
                  : null,
            ),

            SizedBox(height: 30.h),

            // NAME FIELD
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  IconlyLight.profile,
                  color: Colors.white,
                ),
                hintText: "Enter your name",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // EMAIL (READ ONLY)
            TextField(
              readOnly: true,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                prefixIcon: const Icon(IconlyLight.message, color: Colors.grey),
                hintText: u?.email ?? "",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const Spacer(),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  padding: EdgeInsets.all(14.r),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Save Changes",
                        style: TextStyle(color: Colors.white, fontSize: 25.sp),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
