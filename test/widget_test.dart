import 'package:flutter_test/flutter_test.dart';
import 'package:task_management_app/main.dart';
import 'package:task_management_app/screens/splash_screen.dart';

void main() {
  testWidgets('App starts with Splash Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TaskManagementApp());

    // Verify that the splash screen is initially shown.
    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}
