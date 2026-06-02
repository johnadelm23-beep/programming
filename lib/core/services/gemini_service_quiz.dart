import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:programmin/core/constants/api_keys.dart';

class AIService {
  AIService._();

  static String get _apiKey => ApiKeys.openRouter;
  static const String _baseUrl =
      "https://openrouter.ai/api/v1/chat/completions";

  static const String _model = "openai/gpt-4o-mini";

  static Future<String> sendMessage(
    String message,
    List<Map<String, String>> history,
  ) async {
    final seed = DateTime.now().millisecondsSinceEpoch;

    final messages = [
      {
        "role": "system",
        "content":
            """
You are a quiz generator AI.

RULES:
- Always generate UNIQUE questions
- Never repeat previous questions
- Make questions different in wording and structure
- Return ONLY valid JSON array
- No explanations
- No markdown
- Use randomness seed: $seed
""",
      },
    ];

    for (final msg in history) {
      messages.add({
        "role": msg["role"] == "user" ? "user" : "assistant",
        "content": msg["text"] ?? "",
      });
    }

    messages.add({
      "role": "user",
      "content":
          """
$message

IMPORTANT:
- Generate completely NEW questions
- Do NOT repeat old patterns
- Use different phrasing every time
- Random seed: $seed
""",
    });

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        "Authorization": "Bearer $_apiKey",
        "Content-Type": "application/json",
        "HTTP-Referer": "https://yourapp.com",
        "X-Title": "Quiz App",
      },
      body: jsonEncode({
        "model": _model,
        "messages": messages,
        "temperature": 0.9,
        "max_tokens": 1500,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("HTTP ${response.statusCode}: ${response.body}");
    }

    final data = jsonDecode(response.body);

    final text = data["choices"]?[0]?["message"]?["content"];

    if (text == null || text.toString().trim().isEmpty) {
      throw Exception("Empty response");
    }

    return text.toString().trim();
  }
}
