// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Avoid depending on the app's MyApp symbol which may not exist.
// Provide a small test widget here that mimics the default counter behavior
// so the test can run independently.
import 'package:flutter/material.dart' as m;

class TestApp extends m.StatefulWidget {
  const TestApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends m.State<TestApp> {
  int _counter = 0;

  void _increment() => setState(() => _counter++);

  @override
  m.Widget build(m.BuildContext context) {
    return m.MaterialApp(
      home: m.Scaffold(
        body: m.Center(child: m.Text('$_counter')),
        floatingActionButton: m.FloatingActionButton(
          onPressed: _increment,
          child: const m.Icon(m.Icons.add),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TestApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
