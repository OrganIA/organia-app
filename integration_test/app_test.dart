import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:organia/main.dart' as app;
import 'package:organia/src/models/hive/current_hive_user.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/ui/widgets/big_button.dart';
import 'package:organia/src/utils/myhive.dart';

const String baseUrl =
    "http://organia.francecentral.cloudapp.azure.com:8000/api";
// final String baseUrl = "http://10.0.2.2:8000/api";
final Faker faker = Faker();
final String email = faker.internet.email();
final String password = faker.internet.password();
const int success = 200;
const int successPost = 201;
const int unauthorized = 401;
const int unprocessable = 422;
const int serverError = 500;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('App tests', () {
    testWidgets('Bottom Tab bar navigation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder chatsTab = find.byIcon(CupertinoIcons.chat_bubble_2_fill);
      expect(chatsTab, findsOneWidget);
      final Finder accountTab = find.byIcon(CupertinoIcons.person_alt_circle);
      expect(accountTab, findsOneWidget);
      await tester.pumpAndSettle();
      await tester.tap(accountTab);
      await tester.pumpAndSettle();
      await tester.tap(chatsTab);
      await tester.pumpAndSettle();
    });

    testWidgets('Register Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));
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
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });
    testWidgets('Login Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));
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
      await tester.enterText(emailField, email);
      await tester.pumpAndSettle();
      await tester.enterText(passwordField, password);
      await tester.pumpAndSettle();
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));
      final Finder userEmail = find.text(email);
      expect(userEmail, findsOneWidget);
    });

    testWidgets('New Chat test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder newChatButton = find.text("Nouvelle");
      expect(newChatButton, findsOneWidget);
      await tester.tap(newChatButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder newChatTitle = find.text("Nouvelle Conversation");
      final Finder usersAddedText = find.text("Utilisateurs ajoutés");
      final Finder usersNotAddedText = find.text("Utilisateurs non ajoutés");
      final Finder chatNameInput = find.byType(TextField);
      final Finder usersNotAdded = find.byKey(const Key("userNotAddedCard"));
      final Finder createButton = find.byType(BigButton);
      expect(newChatTitle, findsOneWidget);
      expect(chatNameInput, findsOneWidget);
      expect(usersAddedText, findsOneWidget);
      expect(usersNotAddedText, findsOneWidget);
      expect(usersNotAdded, findsWidgets);
      expect(createButton, findsOneWidget);
      await tester.enterText(chatNameInput, "Test");
      await tester.tap(usersNotAdded.first);
      await tester.pump();
      final Finder userToAdd = find.byKey(const Key("userToAddCard"));
      expect(userToAdd, findsOneWidget);
      await tester.tap(createButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });
    testWidgets('Chat List test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder tabTitle = find.text("Conversations");
      final Finder newChat = find.text("Nouvelle");
      expect(tabTitle, findsOneWidget);
      expect(newChat, findsOneWidget);
      await tester.pumpAndSettle();
    });
    testWidgets('Chat Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder chat = find.text("Test");
      expect(chat, findsOneWidget);
      await tester.tap(chat);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder chatTitle = find.text("Test");
      final Finder infosIcon = find.byIcon(Icons.info_outline);
      final Finder messageInput = find.byType(TextField);
      expect(chatTitle, findsOneWidget);
      expect(infosIcon, findsOneWidget);
      expect(messageInput, findsOneWidget);
      await tester.enterText(messageInput, "Ceci est un message de tests.");
    });
    testWidgets('Logout Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder accountTab = find.byIcon(CupertinoIcons.person_alt_circle);
      expect(accountTab, findsOneWidget);
      await tester.tap(accountTab);
      await tester.pumpAndSettle();
      final Finder toLogoutButton = find.byKey(const Key("logoutButton"));
      expect(toLogoutButton, findsOneWidget);
      await tester.tap(toLogoutButton);
      await tester.pumpAndSettle();
      final Finder toLoginButton = find.byKey(const Key("loginBigButton"));
      final Finder toRegisterButton =
          find.byKey(const Key("registerBigButton"));
      expect(toLoginButton, findsOneWidget);
      expect(toRegisterButton, findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
