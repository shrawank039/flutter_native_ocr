// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_native_ocr_example/main.dart';

void main() {
  testWidgets('OCR Example app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app shows the expected text
    expect(find.text('Flutter Native OCR Example'), findsOneWidget);
    expect(find.text('Pick Image from Gallery'), findsOneWidget);

    // Verify the pick image button is present
    expect(find.byIcon(Icons.photo_library), findsOneWidget);
  });
}
