import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';

class CodeWidget extends StatefulWidget {
  final String code;
  final String language;

  const CodeWidget({super.key, required this.code, required this.language});

  @override
  State<CodeWidget> createState() => _CodeWidgetState();
}

class _CodeWidgetState extends State<CodeWidget> {
  bool copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.code));

    setState(() => copied = true);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => copied = false);
    }
  }

  List<String> get lines => widget.code.split('\n');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xff161B22),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          // Header
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 6),

                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 6),

                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 14),

                Text(
                  widget.language.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .8,
                  ),
                ),

                const Spacer(),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: copied
                      ? const Row(
                          key: ValueKey("done"),
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Copied",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      : InkWell(
                          key: const ValueKey("copy"),
                          onTap: _copy,
                          borderRadius: BorderRadius.circular(8),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.copy_rounded,
                              color: Colors.white54,
                              size: 18,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),

          // Code Area
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Line Numbers
                  Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 14,
                      bottom: 14,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(right: BorderSide(color: Colors.white10)),
                    ),
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
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Highlighted Code
                  Container(
                    constraints: const BoxConstraints(minWidth: 250),
                    padding: const EdgeInsets.all(14),
                    child: HighlightView(
                      widget.code,
                      language: widget.language,
                      theme: atomOneDarkTheme,
                      padding: EdgeInsets.zero,
                      textStyle: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        height: 1.55,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
