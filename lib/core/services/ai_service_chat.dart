import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:programmin/core/constants/api_keys.dart';

class AIChatService {
  AIChatService._();

  static String get _apiKey => ApiKeys.openRouter;
  static const String _baseUrl =
      "https://openrouter.ai/api/v1/chat/completions";

  static const String _model = "openai/gpt-4o-mini";

  static Future<String> sendMessage(
    String message,
    List<Map<String, String>> history,
  ) async {
    try {
      final time = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

      final messages = <Map<String, String>>[
        {
          "role": "system",
          "content":
              """
You are a powerful AI assistant.

Rules:
- Be smart, clear, and direct
- Explain like a senior developer when needed
- Do not return JSON
- Current time: $time
""",
        },
      ];

      // add history safely
      for (final msg in history) {
        final role = msg["role"] == "user" ? "user" : "assistant";

        messages.add({"role": role, "content": msg["text"] ?? ""});
      }

      // new message
      messages.add({"role": "user", "content": message});

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          "Authorization": "Bearer $_apiKey",
          "Content-Type": "application/json",
          "HTTP-Referer": "https://yourapp.com",
          "X-Title": "Smart Chat",
        },
        body: jsonEncode({
          "model": _model,
          "messages": messages,
          "temperature": 0.6,
          "max_tokens": 1500,
        }),
      );

      if (response.statusCode != 200) {
        return "Error: ${response.statusCode}";
      }

      final data = jsonDecode(response.body);

      final text = data["choices"]?[0]?["message"]?["content"];

      if (text == null || text.toString().trim().isEmpty) {
        return "I couldn't generate a response.";
      }

      return text.toString().trim();
    } catch (e) {
      return "Something went wrong: $e";
    }
  }
}
