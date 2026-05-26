import 'package:flutter_test/flutter_test.dart';
import 'package:schnurrpurr_web/app.dart';

void main() {
  testWidgets('SchnurrPurr app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SchnurrPurrApp());
    expect(find.text('SchnurrPurr'), findsWidgets);
  });
}
