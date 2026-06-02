import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:programmin/core/services/gemini_service_quiz.dart';
import 'package:programmin/features/game/qustion_model.dart';

class LogicGameService {
  static Future<List<AIQuestion>> generateQuestions(int level) async {
    final response = await AIService.sendMessage("""
Generate 10 programming quiz questions.

RULES:
- Every request must generate UNIQUE questions
- Do NOT repeat previous questions
- Vary topics (variables, loops, OOP, functions, arrays)
- Make difficulty appropriate for level $level
- Each question must be different wording

Return ONLY JSON array:
[
  {
    "question": "What is a variable?",
    "options": ["A", "B", "C", "D"],
    "correctIndex": 0
  }
]

Random seed: ${DateTime.now().millisecondsSinceEpoch}
Level: $level
""", []);

    try {
      final cleaned = response
          .replaceAll("```json", "")
          .replaceAll("```", "")
          .trim();

      final start = cleaned.indexOf('[');
      final end = cleaned.lastIndexOf(']');

      if (start == -1 || end == -1) {
        throw Exception("Invalid JSON");
      }

      final jsonString = cleaned.substring(start, end + 1);

      final List<dynamic> data = jsonDecode(jsonString);

      return data.map((e) => AIQuestion.fromJson(e)).toList();
    } catch (e) {
      debugPrint(response);
      throw Exception("Parse error: $e");
    }
  }
}
