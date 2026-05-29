import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/app_validation.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:programmin/features/auth/ui/widgets/custom_app_button.dart';
import 'package:programmin/features/auth/ui/widgets/custom_header.dart';
import 'package:programmin/features/auth/ui/widgets/custom_text_form_field.dart';
import 'package:programmin/features/auth/ui/login_screen.dart';
import 'package:programmin/features/home/ui/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Account created successfully")),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
              (route) => false,
            );
          }

          if (state is AuthErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },

        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomHeader(),

                    SizedBox(height: 20.h),

                    Text(
                      "Create your account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Text(
                      "Join our community of developers",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                    ),

                    SizedBox(height: 24.h),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              hintText: "Name",
                              icon: Icons.person,
                              controller: _nameController,
                              validator: AppValidator.name,
                            ),

                            SizedBox(height: 16.h),

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

                            SizedBox(height: 16.h),

                            CustomTextFormField(
                              hintText: "Confirm password",
                              icon: Icons.lock,
                              isObsecure: true,
                              controller: _confirmPasswordController,
                              validator: (v) => AppValidator.confirmPassword(
                                v,
                                _passwordController.text,
                              ),
                            ),

                            SizedBox(height: 28.h),

                            CustomAppButton(
                              onPressed: state is AuthLoadingState
                                  ? null
                                  : _register,
                              text: "Register",
                            ),

                            SizedBox(height: 30.h),

                            Text.rich(
                              TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.sp,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign In",
                                    style: TextStyle(
                                      color: AppColors.primaryPurple,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => BlocProvider(
                                              create: (context) => AuthCubit(),
                                              child: const LoginScreen(),
                                            ),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (state is AuthLoadingState)
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
