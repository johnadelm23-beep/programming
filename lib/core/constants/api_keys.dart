import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKeys {
  static String get openRouter => dotenv.env['OPENROUTER_API_KEY'] ?? '';

  static String get youtube => dotenv.env['YOUTUBE_API_KEY'] ?? '';
}
