import 'package:simple_debt_manager/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("App startup: find appbar text", (WidgetTester tester) async {
    await tester.pumpWidget(App());
    expect(find.text("Simple Debt Manager"), findsOneWidget);
  });

  testWidgets("App startup: find bottomNavBar List text", (WidgetTester tester) async {
    await tester.pumpWidget(App());
    expect(find.text("List"), findsOneWidget);
  });

  testWidgets("App startup: find bottomNavBar General text", (WidgetTester tester) async {
    await tester.pumpWidget(App());
    expect(find.text("General"), findsOneWidget);
  });


}
