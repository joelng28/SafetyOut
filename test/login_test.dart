import 'package:app/widgets/email_input.dart';
import 'package:app/widgets/password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'units/loginUnit.dart'; 

void main() {
  testWidgets('Inicia sessió correctament', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: LoginUnit()));

    await tester.enterText(find.byType(EmailInput), 'agustinmillanjimenez@gmail.com');
    expect(find.text('agustinmillanjimenez@gmail.com'), findsOneWidget);
    await tester.enterText(find.byType(PasswordInput), 'Pepito23');
    expect(find.text('Pepito23'), findsOneWidget);
    await tester.tap(find.byKey(Key('loginButton')));
  });

  testWidgets('Accedir a recuperar la contrasenya', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: LoginUnit()));

    await tester.tap(find.text('Has oblidat la contrasenya?'));
  });

  testWidgets('Accedir a recuperar registrar-se', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: LoginUnit()));

    await tester.tap(find.text('Registra\'t'));
  });
}
