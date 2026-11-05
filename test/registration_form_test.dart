import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:astromett/core/theme/app_theme.dart';
import 'package:astromett/features/landing/widgets/registration_form.dart';

void main() {
  testWidgets('Registration form validation and success simulation', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: RegistrationForm(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final reserveBtn = find.text('Reserve My Spot');
    expect(reserveBtn, findsOneWidget);

    // Tap submit while fields are empty to trigger validation
    await tester.tap(reserveBtn);
    await tester.pumpAndSettle();

    // Expect validation errors
    expect(find.text('Please enter your first name'), findsOneWidget);
    expect(find.text('Please enter your email address'), findsOneWidget);
    expect(
      find.text('Please select your birth date for astrological chart analysis'),
      findsOneWidget,
    );

    // Enter invalid name & invalid email
    final nameField = find.widgetWithText(TextFormField, 'First Name');
    final emailField = find.widgetWithText(TextFormField, 'Email Address');

    await tester.enterText(nameField, '1');
    await tester.enterText(emailField, 'notanemail');
    await tester.tap(reserveBtn);
    await tester.pumpAndSettle();

    expect(find.text('Name must be at least 2 characters'), findsOneWidget);
    expect(find.text('Please enter a valid email address'), findsOneWidget);

    // Enter valid details
    await tester.enterText(nameField, 'Aarav');
    await tester.enterText(emailField, 'aarav@astromett.com');

    // Tap date of birth to open date picker
    final dobField = find.widgetWithText(TextFormField, 'Date of Birth');
    await tester.tap(dobField);
    await tester.pumpAndSettle();

    // Tap 'OK' or select date on datepicker dialog
    final okButton = find.text('OK');
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    // Tap submit button to trigger simulation
    await tester.tap(reserveBtn);
    await tester.pump(); // Start loading

    // Verify progress indicator is showing
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Advance time past the simulated 1400ms delay
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();

    // Verify success state
    expect(find.text('Your Spot Is Reserved'), findsOneWidget);
    expect(find.textContaining('Reservation Code: ASTRO-'), findsOneWidget);
    expect(find.textContaining('aarav@astromett.com'), findsOneWidget);
    expect(find.text('Register Another Profile'), findsOneWidget);
  });
}
