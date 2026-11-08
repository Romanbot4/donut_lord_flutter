import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

void main() {
  final strings = AppLocalizationsEn();

  Future<void> pumpPhonePage(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: PhonePage(),
      ),
    );
    await tester.pumpAndSettle();
  }

  bool continueEnabled(WidgetTester tester) => tester
      .widget<StyledPrimaryButton>(find.byType(StyledPrimaryButton))
      .isEnabled;

  testWidgets('Continue stays disabled until the number is valid', (
    tester,
  ) async {
    await pumpPhonePage(tester);
    expect(continueEnabled(tester), isFalse);

    await tester.enterText(find.byType(TextFormField), '0925');
    await tester.pump();
    expect(continueEnabled(tester), isFalse);

    await tester.enterText(find.byType(TextFormField), '09254135592');
    await tester.pump();
    expect(continueEnabled(tester), isTrue);
  });

  testWidgets(
    'shows the invalid number message only after the field loses focus',
    (tester) async {
      await pumpPhonePage(tester);

      await tester.enterText(find.byType(TextFormField), '0925');
      await tester.pump();
      expect(find.text(strings.lblEnterValidPhoneNumber), findsNothing);

      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump();
      expect(find.text(strings.lblEnterValidPhoneNumber), findsOneWidget);
    },
  );
}
