import 'package:app/widgets/email_input.dart';
import 'package:app/widgets/password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../pages/login.dart';

void main() {
  group('Log In Page Widget Tests', () {
    testWidgets('Successful Log In', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: Login()));

      await tester.enterText(find.byType(EmailInput), 'agustinmillanjimenez@gmail.com');
      expect(find.text('agustinmillanjimenez@gmail.com'), findsOneWidget);
      await tester.enterText(find.byType(PasswordInput), 'Pepito23');
      expect(find.text('Pepito23'), findsOneWidget);
      await tester.tap(find.byKey(Key('loginButton')));
    });
    testWidgets('Go to forgotten password', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: Login()));

      await tester.tap(find.text('Has oblidat la contrasenya?'));
    });
    testWidgets('Go to sign up', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: Login()));

      await tester.tap(find.text('Registra\'t'));
    });
  });
}
