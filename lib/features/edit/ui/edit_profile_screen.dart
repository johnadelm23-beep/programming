import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/edit/ui/widgets/custom_avatar.dart';
import 'package:programmin/features/edit/ui/widgets/custom_floating_dots.dart';
import 'package:programmin/features/edit/ui/widgets/custom_save_button.dart';
import 'package:programmin/features/edit/ui/widgets/custom_text_form_field_email.dart';
import 'package:programmin/features/edit/ui/widgets/custom_text_form_field_name.dart';
import 'package:programmin/features/edit/ui/widgets/models/dots_model.dart';
import 'package:programmin/features/home/cubit/cubit/home_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with TickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();

  User? get user => FirebaseAuth.instance.currentUser;

  bool isLoading = false;

  late final AnimationController floatController;
  late final AnimationController buttonController;
  late final AnimationController fadeController;

  late final Animation<double> fade;
  late final Animation<Offset> slide;
  late final Animation<double> scale;

  final List<Dot> dots = [];

  @override
  void initState() {
    super.initState();

    nameController.text = user?.displayName ?? "";

    floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    fade = CurvedAnimation(parent: fadeController, curve: Curves.easeOut);

    slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: fadeController, curve: Curves.easeOut));

    scale = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(parent: fadeController, curve: Curves.elasticOut),
    );

    dots.addAll(
      List.generate(
        15,
        (_) => Dot(
          dx: Random().nextDouble(),
          dy: Random().nextDouble(),
          speed: Random().nextDouble() * 2 + 0.5,
          size: Random().nextDouble() * 6 + 2,
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    floatController.dispose();
    buttonController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  Future<void> updateProfile() async {
    final newName = nameController.text.trim();

    if (newName.isEmpty || user == null) return;

    setState(() => isLoading = true);

    buttonController.forward(from: 0);

    try {
      await user!.updateDisplayName(newName);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .update({"name": newName});

      await FirebaseAuth.instance.currentUser?.reload();

      if (mounted) {
        context.read<HomeCubit>().getUserData();
      }

      setState(() {});

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile Updated"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xFF1A1A2E), Color(0xFF060913)],
              ),
            ),
          ),
          CustomFloatingDots(
            floatController: floatController,
            size: size,
            dots: dots,
          ),
          SafeArea(
            child: FadeTransition(
              opacity: fade,
              child: SlideTransition(
                position: slide,
                child: ScaleTransition(
                  scale: scale,
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        CustomAvatar(user: user),
                        SizedBox(height: 30.h),
                        CustomTextFormFieldName(
                          icon: IconlyLight.profile,
                          controller: nameController,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextFormFieldEmail(user: user),
                        const Spacer(),
                        CustomSaveButton(
                          onTap: updateProfile,
                          isLoading: isLoading,
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
