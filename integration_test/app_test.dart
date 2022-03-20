import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:organia/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
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
  });
}
