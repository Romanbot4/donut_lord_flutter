import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

import '../../../support/auth_fakes.dart';

void main() {
  final strings = AppLocalizationsEn();
  late FakeAuthRepository auth;
  late MemoryUserRepository users;
  late SessionCubit session;

  setUp(() {
    auth = FakeAuthRepository();
    users = MemoryUserRepository();
    session = buildSessionCubit(auth, users);
  });

  tearDown(() => session.close());

  Future<void> pumpOtpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      localizedApp(
        BlocProvider(
          create: (_) => OtpCubit(
            SendOtpUseCase(auth),
            VerifyOtpUseCase(auth, users),
            session,
          ),
          child: const OtpPage(phoneNumber: '+959254135592'),
        ),
      ),
    );
    await tester.pump();
  }

  Future<void> enterCode(WidgetTester tester, String code) async {
    await tester.enterText(find.byType(EditableText), code);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
  }

  Future<void> disposePage(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  }

  testWidgets(
    'a wrong code shows the wrong code message and clears the boxes',
    (tester) async {
      await pumpOtpPage(tester);

      await enterCode(tester, wrongOtp);

      expect(find.text(strings.lblOtpWrong), findsOneWidget);
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).controller.text,
        isEmpty,
      );
      await disposePage(tester);
    },
  );

  testWidgets('three wrong codes lock entry until a new code is sent', (
    tester,
  ) async {
    await pumpOtpPage(tester);

    for (var attempt = 0; attempt < OtpCubit.maxWrongAttempts; attempt++) {
      await enterCode(tester, wrongOtp);
    }

    expect(find.text(strings.lblOtpLocked), findsOneWidget);
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).readOnly,
      isTrue,
    );
    await disposePage(tester);
  });

  testWidgets(
    'a code typed while the OTP is still sending is verified once it is sent',
    (tester) async {
      auth = FakeAuthRepository(sendDelay: const Duration(seconds: 1));
      session = buildSessionCubit(auth, users);
      await pumpOtpPage(tester);

      await tester.enterText(find.byType(EditableText), validOtp);
      await tester.pump(const Duration(seconds: 2));

      expect(session.state, isA<SessionAuthenticated>());
      await disposePage(tester);
    },
  );

  testWidgets('the right code signs the new user in', (tester) async {
    await pumpOtpPage(tester);

    await enterCode(tester, validOtp);

    expect(session.state, isA<SessionAuthenticated>());
    expect(auth.savedToken, isNotNull);
    await disposePage(tester);
  });
}
