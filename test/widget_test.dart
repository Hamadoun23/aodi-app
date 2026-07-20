import 'package:flutter_test/flutter_test.dart';

import 'package:aodi_app/main.dart';

void main() {
  testWidgets('AODI app builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const AodiApp());
    expect(find.text('Bonjour Astou 👋'), findsOneWidget);
  });
}
