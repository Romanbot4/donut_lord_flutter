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

  Future<void> pumpNamePage(WidgetTester tester) async {
    await tester.pumpWidget(
      routedApp(
        BlocProvider(
          create: (_) => UserNameCubit(UpdateUserInfoUseCase(users), session),
          child: const UserNamePage(),
        ),
        otherPaths: [DateOfBirthPage.routePath],
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder field(int index) => find.byType(TextFormField).at(index);

  Future<void> tapContinue(WidgetTester tester) async {
    await tester.tap(find.byType(StyledPrimaryButton));
    await tester.pumpAndSettle();
  }

  testWidgets('requires a first name', (tester) async {
    await pumpNamePage(tester);

    await tapContinue(tester);

    expect(find.text(strings.lblFirstNameRequired), findsOneWidget);
    expect(users.lastUpdate, isNull);
  });

  testWidgets('rejects digits in a name', (tester) async {
    await pumpNamePage(tester);

    await tester.enterText(field(0), 'Ye Min 2');
    await tapContinue(tester);

    expect(find.text(strings.lblNameInvalid), findsOneWidget);
    expect(users.lastUpdate, isNull);
  });

  testWidgets('saves the name without a last name', (tester) async {
    await pumpNamePage(tester);

    await tester.enterText(field(0), 'Ye Min');
    await tapContinue(tester);

    expect(users.lastUpdate?.name, 'Ye Min');
    expect(find.text(DateOfBirthPage.routePath), findsOneWidget);
  });
}
