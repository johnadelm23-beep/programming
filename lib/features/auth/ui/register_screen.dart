import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/app_validation.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/auth/ui/widgets/custom_app_button.dart';
import 'package:programmin/features/auth/ui/widgets/custom_header.dart';
import 'package:programmin/features/auth/ui/widgets/custom_text_form_field.dart';
import 'package:programmin/features/home/ui/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            CustomHeader(),
            SizedBox(height: 10.h),
            Text(
              "Create your account",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "Join our community of developers",
              style: TextStyle(fontSize: 16.sp, color: Colors.grey),
            ),
            SizedBox(height: 10.h),
            Form(
              key: _formKey,
              child: Column(
                spacing: 15.h,
                children: [
                  CustomTextFormField(
                    hintText: "Name",
                    icon: Icons.person,
                    controller: _nameController,
                    validator: (v) => AppValidator.name(v),
                  ),
                  CustomTextFormField(
                    hintText: "Email",
                    icon: Icons.email,
                    controller: _emailController,
                    validator: (v) => AppValidator.email(v),
                  ),
                  CustomTextFormField(
                    hintText: "Password",
                    icon: Icons.lock,
                    isObsecure: true,
                    controller: _passwordController,
                    validator: (v) => AppValidator.password(v),
                  ),
                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    hintText: "Confirm password",
                    icon: Icons.lock,
                    isObsecure: true,
                    validator: (v) => AppValidator.confirmPassword(
                      v,
                      _passwordController.text,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomAppButton(
                    text: "Register",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
