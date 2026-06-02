import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/app_validation.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:programmin/features/auth/ui/widgets/custom_app_button.dart';
import 'package:programmin/features/auth/ui/widgets/custom_header.dart';
import 'package:programmin/features/auth/ui/widgets/custom_sign_in_google_button.dart';
import 'package:programmin/features/auth/ui/widgets/custom_text_form_field.dart';
import 'package:programmin/features/auth/ui/widgets/custom_text_rich.dart';
import 'package:programmin/features/home/cubit/cubit/home_cubit.dart';
import 'package:programmin/features/mainScreen/ui/main_shell_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  void _googleLogin() {
    context.read<AuthCubit>().signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => HomeCubit(),
                  child: const MainShellScreen(),
                ),
              ),
              (route) => false,
            );
          }

          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.red, content: Text(state.error)),
            );
          }
        },

        builder: (context, state) {
          final isLoading = state is AuthLoadingState;

          return Stack(
            children: [
              AbsorbPointer(
                absorbing: isLoading,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CustomHeader(),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Form(
                          key: _formKey,
                          child: Column(
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
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                ),
                              ),

                              SizedBox(height: 32.h),

                              /// EMAIL
                              CustomTextFormField(
                                hintText: "Email",
                                icon: Icons.email,
                                controller: _emailController,
                                validator: AppValidator.email,
                              ),

                              SizedBox(height: 16.h),

                              /// PASSWORD
                              CustomTextFormField(
                                hintText: "Password",
                                icon: Icons.lock,
                                isObsecure: true,
                                controller: _passwordController,
                                validator: AppValidator.password,
                              ),

                              SizedBox(height: 24.h),

                              /// LOGIN BUTTON
                              CustomAppButton(
                                text: isLoading ? "Loading..." : "Login",
                                onPressed: isLoading ? null : _login,
                              ),

                              SizedBox(height: 24.h),

                              Text(
                                "or continue with",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                ),
                              ),

                              SizedBox(height: 24.h),

                              CustomSignInGoogleButton(
                                onTap: _googleLogin,
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
              ),

              /// LOADING OVERLAY
              if (isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
