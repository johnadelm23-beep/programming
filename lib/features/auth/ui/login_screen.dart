import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/app_validation.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/auth/ui/widgets/custom_app_button.dart';
import 'package:programmin/features/auth/ui/widgets/custom_header.dart';
import 'package:programmin/features/auth/ui/widgets/custom_sign_in_google_button.dart';
import 'package:programmin/features/auth/ui/widgets/custom_text_form_field.dart';
import 'package:programmin/features/auth/ui/widgets/custom_text_rich.dart';
import 'package:programmin/features/home/ui/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 24.h),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Login to continue your coding journey",
                      style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    ),
                    SizedBox(height: 32.h),
                    CustomTextFormField(
                      hintText: "Email",
                      icon: Icons.email,
                      controller: _emailController,
                      validator: AppValidator.email,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      hintText: "Password",
                      icon: Icons.lock,
                      isObsecure: true,
                      controller: _passwordController,
                      validator: AppValidator.password,
                    ),
                    SizedBox(height: 24.h),
                    CustomAppButton(
                      text: _isLoading ? "Logging in..." : "Login",
                      onPressed: _isLoading ? null : _login,
                    ),

                    SizedBox(height: 24.h),

                    Text(
                      "or continue with",
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                    SizedBox(height: 24.h),
                    const CustomSignInGoogleButton(
                      text: "Continue With Google",
                      icon: "assets/icons/google.svg",
                      backgroundColor: AppColors.backgroundColor,
                    ),
                    SizedBox(height: 32.h),
                    const CustomTextRich(
                      textOne: "Don't have an account? ",
                      textTwo: "Sign Up",
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
