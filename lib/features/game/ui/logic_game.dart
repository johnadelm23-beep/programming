import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/game/logic_game_services.dart';
import 'package:programmin/features/game/qustion_model.dart';

class LogicGame extends StatefulWidget {
  const LogicGame({super.key});

  @override
  State<LogicGame> createState() => _LogicGameState();
}

class _LogicGameState extends State<LogicGame> {
  List<AIQuestion> questions = [];

  int level = 1;
  int index = 0;

  int levelScore = 0;
  int totalScore = 0;

  bool loading = true;
  bool locked = false;
  bool gameFinished = false;

  int? selectedIndex;
  bool? isCorrectAnswer;

  int _actionId = 0;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    setState(() {
      loading = true;
      locked = true;

      index = 0;
      levelScore = 0;

      selectedIndex = null;
      isCorrectAnswer = null;
    });

    final result = await LogicGameService.generateQuestions(level);

    if (!mounted) return;

    setState(() {
      questions = result;
      loading = false;
      locked = false;
    });
  }

  void selectAnswer(String answer) {
    if (locked || gameFinished || questions.isEmpty) return;

    final current = questions[index];
    final actionId = ++_actionId;

    final isCorrect = current.options.indexOf(answer) == current.correctIndex;

    setState(() {
      locked = true;
      selectedIndex = current.options.indexOf(answer);
      isCorrectAnswer = isCorrect;

      if (isCorrect) levelScore++;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      if (actionId != _actionId) return;

      _next();
    });
  }

  void _next() {
    setState(() {
      locked = false;
      selectedIndex = null;
      isCorrectAnswer = null;
    });

    if (index + 1 < questions.length) {
      setState(() => index++);
    } else {
      _endLevel();
    }
  }

  void _endLevel() {
    final passed = levelScore >= 5;

    totalScore += levelScore;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.backgroundColor,
        content: Text(
          passed ? "Level $level passed " : "Try again ❌",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    if (passed) level++;

    if (level <= 3) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        loadQuestions();
      });
    } else {
      setState(() => gameFinished = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final current = questions[index];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(IconlyLight.arrow_left_2, color: Colors.white),
        ),
        backgroundColor: AppColors.backgroundColor,
        title: Text("Level $level", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Score: $levelScore",
              style: const TextStyle(color: Colors.white),
            ),

            SizedBox(height: 20.h),

            Text(
              current.question,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),

            SizedBox(height: 20.h),

            ...current.options.asMap().entries.map((e) {
              final i = e.key;
              final option = e.value;

              Color color = AppColors.cardColor;

              if (selectedIndex == i) {
                color = isCorrectAnswer == true ? Colors.green : Colors.red;
              }

              return GestureDetector(
                onTap: () => selectAnswer(option),
                child: Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    option,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
