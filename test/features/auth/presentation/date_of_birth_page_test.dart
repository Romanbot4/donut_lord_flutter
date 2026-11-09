import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

import '../../../support/auth_fakes.dart';

void main() {
  final strings = AppLocalizationsEn();
  late MemoryUserRepository users;
  late SessionCubit session;

  setUp(() async {
    users = MemoryUserRepository();
    session = buildSessionCubit(FakeAuthRepository(), users);
    await session.signIn(registeringUser, isNewUser: true);
  });

  tearDown(() => session.close());

  Future<void> pumpDateOfBirthPage(WidgetTester tester) async {
    await tester.pumpWidget(
      localizedApp(
        BlocProvider(
          create: (_) =>
              DateOfBirthCubit(UpdateUserInfoUseCase(users), session),
          child: const DateOfBirthPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> enterDate(
    WidgetTester tester, {
    required String month,
    required String day,
    required String year,
  }) async {
    await tester.tap(find.text(strings.lblMonth));
    await tester.pumpAndSettle();
    await tester.tap(find.text(month));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), day);
    await tester.enterText(find.byType(TextFormField).at(1), year);
    await tester.pumpAndSettle();
  }

  bool continueEnabled(WidgetTester tester) => tester
      .widget<StyledPrimaryButton>(find.byType(StyledPrimaryButton))
      .isEnabled;

  testWidgets('Continue stays disabled until the date is complete', (
    tester,
  ) async {
    await pumpDateOfBirthPage(tester);

    expect(continueEnabled(tester), isFalse);
  });

  testWidgets('rejects a day that does not exist in the month', (tester) async {
    await pumpDateOfBirthPage(tester);

    await enterDate(tester, month: 'April', day: '31', year: '1990');

    expect(find.text(strings.lblDateOfBirthInvalid), findsOneWidget);
    expect(continueEnabled(tester), isFalse);
  });

  testWidgets('rejects anyone younger than the minimum age', (tester) async {
    await pumpDateOfBirthPage(tester);

    await enterDate(
      tester,
      month: 'January',
      day: '1',
      year: '${DateTime.now().year - 1}',
    );

    expect(
      find.text(
        strings.lblDateOfBirthTooYoung(DateOfBirthValidator.minimumAge),
      ),
      findsOneWidget,
    );
    expect(continueEnabled(tester), isFalse);
  });

  testWidgets('accepts a valid date of birth', (tester) async {
    await pumpDateOfBirthPage(tester);

    await enterDate(tester, month: 'May', day: '1', year: '1990');

    expect(continueEnabled(tester), isTrue);
  });
}
