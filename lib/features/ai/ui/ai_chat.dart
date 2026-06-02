import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/services/ai_service_chat.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/core/services/gemini_service_quiz.dart';
import 'package:programmin/core/widgets/code_widget.dart';
import 'package:programmin/features/ai/ui/widgets/custom_animated_container.dart';
import 'package:programmin/features/ai/ui/widgets/custom_app_bar_chat_screen.dart';
import 'package:programmin/features/ai/ui/widgets/custom_container_input.dart';
import 'package:programmin/features/ai/ui/widgets/custom_drawer_chat_screen.dart';
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

  void _copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Copied ✔")));
  }

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
      final response = await AIChatService.sendMessage(text, chat.messages);
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

  @override
  Widget build(BuildContext context) {
    final messages = chats[currentIndex].messages;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      drawer: CustomDrawerChatScreen(
        onTapNewChat: _newChat,
        onPressedDeleteChat: _deleteChat,
        chats: chats,
        currentIndex: currentIndex,
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: bgController,
            builder: (_, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      // ignore: deprecated_member_use
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
                CustomAppBarChatScreen(),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.all(12.r),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isUser = msg["role"] == "user";
                      return CustomAnimatedContainer(
                        isUser: isUser,
                        msg: msg,
                        copy: _copy,
                        parseMessage: _parseMessage,
                      );
                    },
                  ),
                ),
                if (isTyping)
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: TypingIndicator(),
                  ),

                CustomContainerInput(onTap: _send, controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
