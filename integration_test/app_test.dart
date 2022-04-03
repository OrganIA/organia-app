import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:organia/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final Faker faker = Faker();

  group('Navigation Tests', () {
    testWidgets('Bottom Tab bar navigation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.byIcon(CupertinoIcons.chat_bubble_2_fill), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.person_alt_circle), findsOneWidget);
      await tester.pumpAndSettle();
      final Finder accountTab = find.byIcon(CupertinoIcons.person_alt_circle);
      await tester.tap(accountTab);
      await tester.pumpAndSettle();
      final Finder chatsTab = find.byIcon(CupertinoIcons.chat_bubble_2_fill);
      await tester.tap(chatsTab);
      await tester.pumpAndSettle();
    });
    testWidgets('Register Test', (WidgetTester tester) async {
      app.main();
      final String email = faker.internet.email();
      final String password = faker.internet.password();
      await tester.pumpAndSettle();
      final Finder accountTab = find.byIcon(CupertinoIcons.person_alt_circle);
      expect(accountTab, findsOneWidget);
      await tester.tap(accountTab);
      await tester.pumpAndSettle();
      final Finder toRegisterButton =
          find.byKey(const Key("registerBigButton"));
      expect(toRegisterButton, findsOneWidget);
      await tester.tap(toRegisterButton);
      await tester.pumpAndSettle();
      final Finder emailField = find.byKey(const Key("emailRegisterField"));
      final Finder passwordField =
          find.byKey(const Key("passwordRegisterField"));
      final Finder registerButton = find.byKey(const Key("registerButton"));
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(registerButton, findsOneWidget);
      await tester.enterText(emailField, email);
      await tester.pumpAndSettle();
      await tester.enterText(passwordField, password);
      await tester.pumpAndSettle();
      await tester.tap(registerButton);
      await tester.pumpAndSettle();
    });
    testWidgets('Login Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final Finder accountTab = find.byIcon(CupertinoIcons.person_alt_circle);
      expect(accountTab, findsOneWidget);
      await tester.tap(accountTab);
      await tester.pumpAndSettle();
      final Finder toLoginButton = find.byKey(const Key("loginBigButton"));
      expect(toLoginButton, findsOneWidget);
      await tester.tap(toLoginButton);
      await tester.pumpAndSettle();
      final Finder emailField = find.byKey(const Key("emailLoginField"));
      final Finder passwordField = find.byKey(const Key("passwordLoginField"));
      final Finder loginButton = find.byKey(const Key("loginButton"));
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(loginButton, findsOneWidget);
      await tester.enterText(emailField, "saber@saber.com");
      await tester.pumpAndSettle();
      await tester.enterText(passwordField, "saber");
      await tester.pumpAndSettle();
      await tester.tap(loginButton);
      await tester.pumpAndSettle();
    });
  });
}
