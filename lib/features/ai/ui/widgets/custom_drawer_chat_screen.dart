import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:programmin/features/ai/ui/ai_chat.dart';

// ignore: must_be_immutable
class CustomDrawerChatScreen extends StatefulWidget {
  CustomDrawerChatScreen({
    super.key,
    required this.onTapNewChat,
    required this.onPressedDeleteChat,
    required this.chats,
    required this.currentIndex,
  });
  final void Function() onTapNewChat;
  final void Function(int index) onPressedDeleteChat;
  final List<ChatSession> chats;
  int currentIndex;
  @override
  State<CustomDrawerChatScreen> createState() => _CustomDrawerChatScreenState();
}

class _CustomDrawerChatScreenState extends State<CustomDrawerChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0F0F1A),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 18.h),

            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(IconlyLight.chat, color: Colors.white, size: 22.sp),
                SizedBox(width: 8.w),
                Text(
                  "Chats",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 18.h),

            // NEW CHAT BUTTON
            GestureDetector(
              onTap: widget.onTapNewChat,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Color(0xFF6A3DE8)],
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  children: [
                    Icon(IconlyLight.plus, color: Colors.white, size: 20.sp),
                    SizedBox(width: 10.w),
                    Text(
                      "New Chat",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 14.h),

            Divider(color: Colors.white12),

            // CHATS LIST
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                itemCount: widget.chats.length,
                itemBuilder: (context, index) {
                  final chat = widget.chats[index];

                  final isSelected = widget.currentIndex == index;

                  final lastMessage = chat.messages.isNotEmpty
                      ? chat.messages.last["text"] ?? ""
                      : "No messages yet";

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          // ignore: deprecated_member_use
                          ? Colors.deepPurple.withOpacity(0.25)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14.r),
                      border: isSelected
                          ? Border.all(color: Colors.deepPurpleAccent)
                          : null,
                    ),
                    child: ListTile(
                      onTap: () {
                        setState(() => widget.currentIndex = index);
                        Navigator.pop(context);
                      },

                      leading: Icon(
                        IconlyLight.message,
                        color: isSelected ? Colors.deepPurple : Colors.white70,
                      ),

                      title: Text(
                        chat.title.isNotEmpty ? chat.title : "New Chat",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      subtitle: Text(
                        lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12.sp,
                        ),
                      ),

                      trailing: IconButton(
                        icon: Icon(
                          IconlyLight.delete,
                          color: Colors.redAccent,
                          size: 18.sp,
                        ),
                        onPressed: () => widget.onPressedDeleteChat(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
