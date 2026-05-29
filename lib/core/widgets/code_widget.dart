import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/dracula.dart';

class CodeWidget extends StatelessWidget {
  final String code;
  final String language;

  const CodeWidget({super.key, required this.code, required this.language});

  List<String> _lines() => code.split('\n');

  @override
  Widget build(BuildContext context) {
    final lines = _lines();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0E14),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(language: language, code: code),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LineNumbers(lines: lines),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: const Color(0xFF0A0E14),
                  child: HighlightView(
                    code,
                    language: language,
                    theme: draculaTheme,
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      fontFamily: "monospace",
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String language;
  final String code;

  const _Header({required this.language, required this.code});

  void _copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Code copied")));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0E14),
        border: Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        children: [
          Text(
            language.toUpperCase(),
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _copy(context),
            child: const Icon(
              Icons.copy_rounded,
              size: 16,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}

class _LineNumbers extends StatelessWidget {
  final List<String> lines;

  const _LineNumbers({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: const Color(0xFF0A0E14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          lines.length,
          (index) => Text(
            "${index + 1}",
            style: const TextStyle(
              color: Colors.white24,
              fontSize: 12,
              height: 1.5,
              fontFamily: "monospace",
            ),
          ),
        ),
      ),
    );
  }
}
