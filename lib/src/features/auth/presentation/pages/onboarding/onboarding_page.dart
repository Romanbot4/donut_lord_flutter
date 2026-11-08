import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static const String routePath = "/onboarding";

  @override
  Widget build(BuildContext context) {
    final animate = !MediaQuery.disableAnimationsOf(context);

    return Scaffold(
      body: ColoredBox(
        color: context.theme.cardColor,
        child: Stack(
          children: [
            OnboardingDonutsBackground(animate: animate),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: OnboardingSection(
                animate: animate,
                // Registering and logging in both start with the phone number.
                onTapStart: () => context.push(PhonePage.routePath),
                // No social integration yet (per the brief): show a placeholder.
                onTapSocialLogIn: () => Snacks.info(
                  context,
                  message: context.localizations.lblComingSoon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
