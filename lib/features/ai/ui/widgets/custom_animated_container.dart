import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustomAnimatedContainer extends StatelessWidget {
  const CustomAnimatedContainer({
    super.key,
    required this.isUser,
    required this.msg,
    required this.copy,
    required this.parseMessage,
  });
  final bool isUser;
  final Map<String, String> msg;
  final void Function(String) copy;
  final List<Widget> Function(String) parseMessage;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: GestureDetector(
          onLongPress: () => copy(msg["text"] ?? ""),
          child: Container(
            padding: EdgeInsets.all(14.r),
            constraints: BoxConstraints(maxWidth: 0.78.sw),
            decoration: BoxDecoration(
              gradient: isUser
                  ? LinearGradient(
                      colors: [AppColors.primaryPurple, Colors.deepPurple],
                    )
                  : LinearGradient(
                      colors: [
                        Colors.white.withOpacity(.12),
                        Colors.white.withOpacity(.06),
                      ],
                    ),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: parseMessage(msg["text"] ?? ""),
            ),
          ),
        ),
      ),
    );
  }
}
