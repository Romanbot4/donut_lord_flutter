import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jdonuts/main.dart' as app;
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _seededProductName = 'Mistletoe Romance box';
const _frame = Duration(milliseconds: 100);
const _stepTimeout = Duration(seconds: 15);

final _strings = AppLocalizationsEn();

Future<void> _clearPreviousSession() async {
  await const FlutterSecureStorage().deleteAll();
  await (await SharedPreferences.getInstance()).clear();
}

Future<void> _settle(
  WidgetTester tester, [
  Duration duration = const Duration(seconds: 1),
]) async {
  for (var waited = Duration.zero; waited < duration; waited += _frame) {
    await tester.pump(_frame);
  }
}

Future<void> _waitFor(WidgetTester tester, Finder finder) async {
  for (var waited = Duration.zero; waited < _stepTimeout; waited += _frame) {
    if (finder.evaluate().isNotEmpty) return;
    await tester.pump(_frame);
  }
  expect(finder, findsWidgets);
}

Future<void> _hideKeyboard(WidgetTester tester) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await _settle(tester);
}

Future<void> _tap(WidgetTester tester, Finder target) async {
  await _waitFor(tester, target);
  await tester.ensureVisible(target.first);
  await _settle(tester);
  await tester.tap(target.first);
  await _settle(tester);
}

Future<void> _tapPrimaryButton(WidgetTester tester) async {
  await _hideKeyboard(tester);
  await _tap(tester, find.byType(StyledPrimaryButton));
}

Future<void> _type(WidgetTester tester, Finder field, String text) async {
  await _waitFor(tester, field);
  await tester.enterText(field, text);
  await _settle(tester);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('a new user registers, lands on Home and opens a product', (
    tester,
  ) async {
    await _clearPreviousSession();
    await app.main();
    await _settle(tester, const Duration(seconds: 3));

    await _tap(tester, find.text(_strings.lblLetsGetStarted.toUpperCase()));

    await _waitFor(tester, find.text(_strings.lblEnterPhone));
    await _type(tester, find.byType(TextFormField), '09254135592');
    await _tapPrimaryButton(tester);

    await _waitFor(tester, find.text(_strings.lblEnterOtp));
    await _type(tester, find.byType(EditableText), AuthConfig.fakeOtpCode);

    await _waitFor(tester, find.text(_strings.lblWhatsYourName));
    await _type(tester, find.byType(TextFormField).first, 'Ye Min');
    await _tapPrimaryButton(tester);

    await _waitFor(tester, find.text(_strings.lblWhatsYourDateOfBirth));
    await _tap(tester, find.text(_strings.lblMonth));
    await _tap(tester, find.text('May'));
    await _type(tester, find.byType(TextFormField).at(0), '1');
    await _type(tester, find.byType(TextFormField).at(1), '1990');
    await _tapPrimaryButton(tester);

    await _waitFor(tester, find.text(_strings.lblWelcomeToTheWorldOfJDonuts));
    await _tapPrimaryButton(tester);

    await _tap(tester, find.text(_seededProductName));

    await _waitFor(tester, find.text(_strings.lblWhatsThis));
    expect(find.text(_seededProductName), findsWidgets);
  });
}
