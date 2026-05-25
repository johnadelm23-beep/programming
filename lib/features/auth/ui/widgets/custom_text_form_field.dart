import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.isObsecure = false,
    required this.hintText,
    required this.icon,
    this.controller,
    this.validator,
  });

  final String hintText;
  final IconData icon;
  final bool isObsecure;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isPasswordVisible = false;

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,

      validator: widget.validator,
      controller: widget.controller,

      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },

      obscureText: widget.isObsecure && !isPasswordVisible,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(
        isDense: true,

        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

        prefixIcon: Icon(widget.icon, color: Colors.grey),

        suffixIcon: widget.isObsecure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
              )
            : null,

        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),

        filled: true,
        fillColor: AppColors.cardColor,

        enabledBorder: _border(Colors.grey.withOpacity(0.2)),

        focusedBorder: _border(AppColors.primaryPurple),

        errorBorder: _border(Colors.redAccent),

        focusedErrorBorder: _border(Colors.red),

        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),

        disabledBorder: _border(Colors.grey.withOpacity(0.1)),
      ),
    );
  }
}
