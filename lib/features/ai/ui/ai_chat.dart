import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/core/services/gemini_service.dart';
import 'package:programmin/core/widgets/code_widget.dart';
import 'package:programmin/features/ai/ui/widgets/typing_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class ChatSession {
  String id;
  String title;
  List<Map<String, String>> messages;

  ChatSession({required this.id, required this.title, required this.messages});
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<ChatSession> chats = [];
  int currentIndex = 0;

  bool isTyping = false;
  DateTime? lastRequest;

  late final AnimationController bgController;

  @override
  void initState() {
    super.initState();

    bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _newChat();
  }

  @override
  void dispose() {
    bgController.dispose();
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  // ================= CHAT CONTROL =================

  void _newChat() {
    setState(() {
      chats.add(
        ChatSession(
          id: DateTime.now().toString(),
          title: "New Chat",
          messages: [],
        ),
      );
      currentIndex = chats.length - 1;
    });
  }

  void _deleteChat(int index) {
    setState(() {
      chats.removeAt(index);
      if (chats.isEmpty) _newChat();
      currentIndex = max(0, currentIndex - 1);
    });
  }

  // ================= COPY =================
  void _copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Copied ✔")));
  }

  // ================= SEND =================
  Future<void> _send() async {
    final text = controller.text.trim();
    if (text.isEmpty || isTyping) return;

    final chat = chats[currentIndex];

    setState(() {
      chat.messages.add({"role": "user", "text": text});
      isTyping = true;
    });

    controller.clear();
    _scrollToBottom();

    try {
      final response = await AIService.sendMessage(text, chat.messages);

      setState(() {
        chat.messages.add({"role": "ai", "text": response});
      });
    } catch (e) {
      setState(() {
        chat.messages.add({"role": "ai", "text": "Error: $e"});
      });
    }

    setState(() => isTyping = false);
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 120), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ================= CODE PARSER =================

  List<Widget> _parseMessage(String text) {
    final regex = RegExp(r"```(\w+)?\n([\s\S]*?)```");

    final widgets = <Widget>[];
    int last = 0;

    for (final match in regex.allMatches(text)) {
      final before = text.substring(last, match.start);

      if (before.trim().isNotEmpty) {
        widgets.add(
          SelectableText(
            before.trim(),
            style: TextStyle(color: Colors.white, fontSize: 15.sp, height: 1.4),
          ),
        );
      }

      final lang = match.group(1) ?? "dart";
      final code = match.group(2) ?? "";

      widgets.add(CodeWidget(code: code, language: lang));

      last = match.end;
    }

    final remaining = text.substring(last);
    if (remaining.trim().isNotEmpty) {
      widgets.add(
        SelectableText(
          remaining.trim(),
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }

    return widgets;
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    final messages = chats[currentIndex].messages;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      drawer: _drawer(),

      body: Stack(
        children: [
          AnimatedBuilder(
            animation: bgController,
            builder: (_, __) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF2A1B5A).withOpacity(.7),
                      Colors.black,
                    ],
                    radius: 1.2 + bgController.value * 0.3,
                  ),
                ),
              );
            },
          ),

          SafeArea(
            child: Column(
              children: [
                _appBar(),

                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.all(12.r),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isUser = msg["role"] == "user";

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: EdgeInsets.symmetric(vertical: 6.h),
                        child: Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: GestureDetector(
                            onLongPress: () => _copy(msg["text"] ?? ""),
                            child: Container(
                              padding: EdgeInsets.all(14.r),
                              constraints: BoxConstraints(maxWidth: 0.78.sw),
                              decoration: BoxDecoration(
                                gradient: isUser
                                    ? LinearGradient(
                                        colors: [
                                          AppColors.primaryPurple,
                                          Colors.deepPurple,
                                        ],
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
                                children: _parseMessage(msg["text"] ?? ""),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                if (isTyping)
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: TypingIndicator(),
                  ),

                _input(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= APP BAR =================

  Widget _appBar() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(IconlyLight.category, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            "Demo",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ================= INPUT =================

  Widget _input() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(color: Colors.black.withOpacity(.4)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: "Ask anything...",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: _send,
            child: CircleAvatar(
              radius: 22.r,
              backgroundColor: Colors.deepPurple,
              child: Icon(IconlyLight.send, color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }

  // ================= DRAWER =================

  // ================= DRAWER =================

  Widget _drawer() {
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
              onTap: _newChat,
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
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];

                  final isSelected = currentIndex == index;

                  final lastMessage = chat.messages.isNotEmpty
                      ? chat.messages.last["text"] ?? ""
                      : "No messages yet";

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.deepPurple.withOpacity(0.25)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14.r),
                      border: isSelected
                          ? Border.all(color: Colors.deepPurpleAccent)
                          : null,
                    ),
                    child: ListTile(
                      onTap: () {
                        setState(() => currentIndex = index);
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
                        onPressed: () => _deleteChat(index),
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
